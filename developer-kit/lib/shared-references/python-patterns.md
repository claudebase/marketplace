# Python Expert - Implementation Patterns

## FastAPI Application Pattern

```python
"""FastAPI application with modern patterns."""
from typing import Annotated
from contextlib import asynccontextmanager
from collections.abc import AsyncGenerator

from fastapi import FastAPI, Depends, HTTPException, status
from pydantic import BaseModel, Field, EmailStr
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker


# Pydantic Models with Validation
class UserCreate(BaseModel):
    """User creation request model."""
    email: EmailStr
    name: str = Field(..., min_length=1, max_length=100)
    password: str = Field(..., min_length=8)

    model_config = {"str_strip_whitespace": True}


class UserResponse(BaseModel):
    """User response model."""
    id: int
    email: EmailStr
    name: str

    model_config = {"from_attributes": True}


# Database Setup
engine = create_async_engine(
    "postgresql+asyncpg://user:pass@localhost/db",
    echo=True,
    pool_pre_ping=True,
)
async_session = async_sessionmaker(engine, expire_on_commit=False)


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """Dependency for database sessions."""
    async with async_session() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise


# Lifespan for startup/shutdown
@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    """Application lifespan handler."""
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    await engine.dispose()


# Application with typed dependencies
app = FastAPI(title="Users API", version="1.0.0", lifespan=lifespan)
DBSession = Annotated[AsyncSession, Depends(get_db)]


@app.post("/users", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def create_user(user: UserCreate, db: DBSession) -> User:
    """Create a new user with validation and error handling."""
    existing = await db.execute(select(User).where(User.email == user.email))
    if existing.scalar_one_or_none():
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Email already registered")

    db_user = User(email=user.email, name=user.name, password_hash=hash_password(user.password))
    db.add(db_user)
    await db.flush()
    return db_user
```

## Django Model Pattern

```python
"""Django models with custom manager and queries."""
from django.db import models
from django.db.models import Q, F, Count, Avg, Sum
from django.db.models.functions import TruncMonth


class UserManager(models.Manager["User"]):
    """Custom manager for User model."""

    def active(self) -> models.QuerySet["User"]:
        return self.filter(is_active=True)

    def with_order_stats(self) -> models.QuerySet["User"]:
        return self.annotate(
            total_orders=Count("orders"),
            total_spent=Sum("orders__total"),
            avg_order_value=Avg("orders__total"),
        )


class Order(models.Model):
    """Order model with proper constraints."""

    class Status(models.TextChoices):
        PENDING = "pending", "Pending"
        PROCESSING = "processing", "Processing"
        SHIPPED = "shipped", "Shipped"

    user = models.ForeignKey(User, on_delete=models.PROTECT, related_name="orders")
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PENDING)
    total = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        constraints = [models.CheckConstraint(check=Q(total__gte=0), name="order_total_positive")]

    @classmethod
    def monthly_stats(cls, year: int) -> models.QuerySet:
        return (
            cls.objects.filter(created_at__year=year)
            .annotate(month=TruncMonth("created_at"))
            .values("month")
            .annotate(count=Count("id"), total=Sum("total"), avg=Avg("total"))
            .order_by("month")
        )
```

## Protocol-Based Interfaces

```python
"""Protocol-based interfaces for dependency injection."""
from typing import Protocol, TypeVar, runtime_checkable
from collections.abc import Sequence

T = TypeVar("T")
ID = TypeVar("ID")


@runtime_checkable
class Repository(Protocol[T, ID]):
    """Generic repository protocol."""

    async def get(self, id: ID) -> T | None: ...
    async def get_all(self) -> Sequence[T]: ...
    async def add(self, entity: T) -> T: ...
    async def update(self, entity: T) -> T: ...
    async def delete(self, id: ID) -> bool: ...


@runtime_checkable
class UnitOfWork(Protocol):
    """Unit of Work protocol for transaction management."""

    async def __aenter__(self) -> "UnitOfWork": ...
    async def __aexit__(self, *args) -> None: ...
    async def commit(self) -> None: ...
    async def rollback(self) -> None: ...


class CacheProtocol(Protocol):
    """Cache protocol for caching implementations."""

    async def get(self, key: str) -> str | None: ...
    async def set(self, key: str, value: str, ttl: int | None = None) -> None: ...
    async def delete(self, key: str) -> bool: ...
```

## Async Service Pattern

```python
"""Async service with proper error handling and retry logic."""
from dataclasses import dataclass
from typing import TypeVar, Generic
from tenacity import retry, stop_after_attempt, wait_exponential, retry_if_exception_type
import httpx

T = TypeVar("T")


@dataclass
class ServiceError(Exception):
    message: str
    code: str
    details: dict | None = None


@dataclass
class ServiceResult(Generic[T]):
    """Result wrapper for service operations."""
    success: bool
    data: T | None = None
    error: ServiceError | None = None

    @classmethod
    def ok(cls, data: T) -> "ServiceResult[T]":
        return cls(success=True, data=data)

    @classmethod
    def fail(cls, error: ServiceError) -> "ServiceResult[T]":
        return cls(success=False, error=error)


class ExternalAPIClient:
    """Client for external API with retry and circuit breaker."""

    def __init__(self, base_url: str, timeout: float = 30.0):
        self.base_url = base_url
        self.timeout = timeout
        self._client: httpx.AsyncClient | None = None

    async def __aenter__(self) -> "ExternalAPIClient":
        self._client = httpx.AsyncClient(base_url=self.base_url, timeout=self.timeout)
        return self

    async def __aexit__(self, *args) -> None:
        if self._client:
            await self._client.aclose()

    @retry(
        stop=stop_after_attempt(3),
        wait=wait_exponential(multiplier=1, min=1, max=10),
        retry=retry_if_exception_type(httpx.TransportError),
    )
    async def _request(self, method: str, path: str, **kwargs) -> httpx.Response:
        response = await self._client.request(method, path, **kwargs)
        response.raise_for_status()
        return response
```

## Testing Patterns

```python
"""Comprehensive testing patterns with pytest."""
from typing import AsyncGenerator
import pytest
from httpx import AsyncClient


@pytest.fixture
async def db_session() -> AsyncGenerator[AsyncSession, None]:
    """Create test database session."""
    engine = create_async_engine("sqlite+aiosqlite:///:memory:", echo=True)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    async with AsyncSession(engine) as session:
        yield session
    await engine.dispose()


@pytest.fixture
async def client(db_session: AsyncSession) -> AsyncGenerator[AsyncClient, None]:
    """Create test client with overridden dependencies."""
    app.dependency_overrides[get_db] = lambda: db_session
    async with AsyncClient(app=app, base_url="http://test") as client:
        yield client
    app.dependency_overrides.clear()


class TestUserAPI:
    @pytest.mark.anyio
    async def test_create_user_success(self, client: AsyncClient) -> None:
        response = await client.post("/users", json={
            "email": "test@example.com",
            "name": "Test User",
            "password": "securepass123",
        })
        assert response.status_code == 201
        assert response.json()["email"] == "test@example.com"

    @pytest.mark.anyio
    @pytest.mark.parametrize("invalid_data,expected_field", [
        ({"email": "invalid", "name": "Test", "password": "pass1234"}, "email"),
        ({"email": "test@test.com", "name": "", "password": "pass1234"}, "name"),
    ])
    async def test_create_user_validation(self, client: AsyncClient, invalid_data: dict, expected_field: str) -> None:
        response = await client.post("/users", json=invalid_data)
        assert response.status_code == 422


# Property-based testing with Hypothesis
from hypothesis import given, strategies as st

class TestUserValidation:
    @given(email=st.emails(), name=st.text(min_size=1, max_size=100))
    def test_valid_user_data(self, email: str, name: str) -> None:
        user = UserCreate(email=email, name=name, password="securepass123")
        assert user.email == email
```

## Pydantic Models with Validation

```python
"""Pydantic models with advanced validation."""
from typing import Annotated, Self
from pydantic import BaseModel, Field, EmailStr, field_validator, model_validator, ConfigDict


class OrderItem(BaseModel):
    product_id: int = Field(..., gt=0)
    quantity: int = Field(..., ge=1, le=100)
    unit_price: Decimal = Field(..., ge=0, decimal_places=2)

    @property
    def total(self) -> Decimal:
        return self.unit_price * self.quantity


class OrderCreate(BaseModel):
    customer_email: EmailStr
    items: list[OrderItem] = Field(..., min_length=1, max_length=50)
    shipping_address: Address
    discount_code: str | None = Field(None, pattern=r"^[A-Z0-9]{6,10}$")

    model_config = ConfigDict(str_strip_whitespace=True, validate_default=True)

    @field_validator("items")
    @classmethod
    def validate_unique_products(cls, items: list[OrderItem]) -> list[OrderItem]:
        product_ids = [item.product_id for item in items]
        if len(product_ids) != len(set(product_ids)):
            raise ValueError("Duplicate products not allowed in single order")
        return items

    @model_validator(mode="after")
    def set_billing_address(self) -> Self:
        if self.billing_address is None:
            self.billing_address = self.shipping_address
        return self
```

## CLI Application (Typer)

```python
"""CLI application with Typer and rich output."""
from typing import Annotated, Optional
from pathlib import Path
import typer
from rich.console import Console
from rich.table import Table

app = typer.Typer(name="myapp", help="My awesome CLI application.")
console = Console()


@app.command()
def process(
    input_file: Annotated[Path, typer.Argument(exists=True, help="Input file to process.")],
    output: Annotated[Optional[Path], typer.Option("--output", "-o")] = None,
    verbose: Annotated[bool, typer.Option("--verbose", "-v")] = False,
) -> None:
    """Process input file and generate output."""
    if verbose:
        console.print(f"[blue]Processing:[/] {input_file}")

    result = process_file(input_file)

    table = Table(title="Results")
    for key in result[0].keys():
        table.add_column(key)
    for row in result:
        table.add_row(*[str(v) for v in row.values()])
    console.print(table)
```

## Concurrency Patterns

```python
"""Modern Python concurrency patterns."""
import asyncio
from typing import TypeVar, Callable, Awaitable

T = TypeVar("T")


async def gather_with_concurrency(limit: int, *coros: Awaitable[T]) -> list[T]:
    """Run coroutines with limited concurrency."""
    semaphore = asyncio.Semaphore(limit)

    async def limited_coro(coro: Awaitable[T]) -> T:
        async with semaphore:
            return await coro

    return await asyncio.gather(*[limited_coro(c) for c in coros])


# TaskGroup pattern (Python 3.11+)
async def fetch_all_with_taskgroup(urls: list[str]) -> list[dict]:
    """Fetch multiple URLs using TaskGroup."""
    results = []
    async with asyncio.TaskGroup() as tg:
        async def fetch_and_store(url: str) -> None:
            async with httpx.AsyncClient() as client:
                response = await client.get(url)
                results.append(response.json())
        for url in urls:
            tg.create_task(fetch_and_store(url))
    return results


# Async iterator pattern
class AsyncDataFetcher:
    """Async iterator for paginated data."""
    def __init__(self, base_url: str, page_size: int = 100):
        self.base_url = base_url
        self.page_size = page_size
        self._current_page = 0

    def __aiter__(self):
        return self

    async def __anext__(self) -> list[dict]:
        async with httpx.AsyncClient() as client:
            response = await client.get(f"{self.base_url}?page={self._current_page}")
            data = response.json()
            if not data["items"]:
                raise StopAsyncIteration
            self._current_page += 1
            return data["items"]
```

## Security Patterns

```python
"""Python security patterns."""
import secrets
from datetime import datetime, timedelta, timezone
from argon2 import PasswordHasher
from argon2.exceptions import VerifyMismatchError
import jwt

ph = PasswordHasher()
SECRET_KEY = secrets.token_urlsafe(32)


def hash_password(password: str) -> str:
    """Hash password using Argon2."""
    return ph.hash(password)


def verify_password(password: str, hash: str) -> bool:
    """Verify password against hash."""
    try:
        ph.verify(hash, password)
        return True
    except VerifyMismatchError:
        return False


def create_access_token(data: dict, expires_delta: timedelta = timedelta(hours=1)) -> str:
    """Create JWT access token."""
    to_encode = data.copy()
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode.update({"exp": expire, "iat": datetime.now(timezone.utc)})
    return jwt.encode(to_encode, SECRET_KEY, algorithm="HS256")
```

## Anti-Patterns to Avoid

```python
# BAD: Mutable default arguments
def add_item(item, items=[]):  # items is shared across calls!
    items.append(item)

# GOOD: Use None as default
def add_item(item, items=None):
    if items is None:
        items = []
    items.append(item)


# BAD: Catching all exceptions
try:
    do_something()
except:  # Catches SystemExit, KeyboardInterrupt too!
    pass

# GOOD: Catch specific exceptions
try:
    do_something()
except ValueError as e:
    logger.error("Invalid value: %s", e)


# BAD: String concatenation in loops (O(n²))
result = ""
for item in items:
    result += str(item)

# GOOD: Use join (O(n))
result = "".join(str(item) for item in items)


# BAD: Not using context managers
f = open("file.txt")
try:
    data = f.read()
finally:
    f.close()

# GOOD: Use with statement
with open("file.txt") as f:
    data = f.read()
```

## pyproject.toml Configuration

```toml
[project]
name = "myproject"
version = "1.0.0"
requires-python = ">=3.11"
dependencies = [
    "fastapi>=0.109.0",
    "pydantic>=2.5.0",
    "sqlalchemy[asyncio]>=2.0.0",
]

[project.optional-dependencies]
dev = ["pytest>=8.0.0", "mypy>=1.8.0", "ruff>=0.1.0"]

[tool.ruff]
target-version = "py311"
select = ["E", "W", "F", "I", "B", "C4", "UP", "S", "ASYNC"]

[tool.mypy]
python_version = "3.11"
strict = true

[tool.pytest.ini_options]
asyncio_mode = "auto"
addopts = ["-v", "--cov=myproject", "--cov-fail-under=90"]
```

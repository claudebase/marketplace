#!/bin/bash
# Migration Metrics Script
# Tracks progress of skill-centric architecture migration

cd "$(dirname "$0")/.." || exit 1

echo "=== Developer Kit Migration Metrics ==="
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Total lines of code
echo "=== Total Lines ==="
total_skills=$(find skills -name "SKILL.md" -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')
total_agents=$(wc -l agents/*.md 2>/dev/null | tail -1 | awk '{print $1}')
total_commands=$(find commands -name "*.md" -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')
total_refs=$(find lib/shared-references -name "*.md" -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')

echo "  Skills: $total_skills lines"
echo "  Agents: $total_agents lines"
echo "  Commands: $total_commands lines"
echo "  Shared References: $total_refs lines"
echo "  TOTAL: $((total_skills + total_agents + total_commands)) lines (excl. refs)"
echo ""

# Skill metrics
echo "=== Skill Metrics ==="
skill_count=$(ls -d skills/*/ 2>/dev/null | wc -l | tr -d ' ')
skill_avg=$(find skills -name "SKILL.md" -exec wc -l {} + 2>/dev/null | awk 'NR>1{sum+=$1; count++} END {if(count>0) printf "%.0f", sum/count; else print "N/A"}')
echo "  Count: $skill_count"
echo "  Avg lines: $skill_avg"
echo "  Target avg: 100"
echo ""

# Check for new frontmatter fields
skills_with_composable=$(grep -l "^composable:" skills/*/SKILL.md 2>/dev/null | wc -l | tr -d ' ')
skills_with_mode=$(grep -l "^mode:" skills/*/SKILL.md 2>/dev/null | wc -l | tr -d ' ')
echo "  Skills with composable: field: $skills_with_composable/$skill_count"
echo "  Skills with mode: field: $skills_with_mode/$skill_count"
echo ""

# Agent metrics
echo "=== Agent Metrics ==="
agent_count=$(ls agents/*.md 2>/dev/null | wc -l | tr -d ' ')
agent_avg=$(wc -l agents/*.md 2>/dev/null | awk 'NR>1{sum+=$1; count++} END {if(count>0) printf "%.0f", sum/count; else print "N/A"}')
echo "  Count: $agent_count"
echo "  Avg lines: $agent_avg"
echo "  Target avg: 200"
echo ""

# Check for new frontmatter fields
agents_with_skills=$(grep -l "^skills:" agents/*.md 2>/dev/null | wc -l | tr -d ' ')
agents_with_expertise=$(grep -l "^expertise:" agents/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "  Agents with skills: field: $agents_with_skills/$agent_count"
echo "  Agents with expertise: field: $agents_with_expertise/$agent_count"
echo ""

# Command metrics
echo "=== Command Metrics ==="
command_count=$(find commands -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
command_avg=$(find commands -name "*.md" -exec wc -l {} + 2>/dev/null | awk 'NR>1{sum+=$1; count++} END {if(count>0) printf "%.0f", sum/count; else print "N/A"}')
commands_over_100=$(find commands -name "*.md" -exec wc -l {} + 2>/dev/null | awk '$1 > 100 && !/total/ {count++} END {print count+0}')
echo "  Count: $command_count"
echo "  Avg lines: $command_avg"
echo "  Target avg: 75"
echo "  Commands over 100 lines: $commands_over_100"
echo ""

# Shared references
echo "=== Shared References ==="
ref_count=$(find lib/shared-references -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
echo "  Count: $ref_count"
echo "  Target: 20 (6 new files needed)"
echo ""

# Duplication indicators
echo "=== Duplication Indicators ==="
mcp_context7=$(grep -r "mcp__context7" skills agents 2>/dev/null | wc -l | tr -d ' ')
mcp_github=$(grep -r "mcp__github" skills agents 2>/dev/null | wc -l | tr -d ' ')
mcp_tavily=$(grep -r "mcp__tavily" skills agents 2>/dev/null | wc -l | tr -d ' ')
mcp_sequential=$(grep -r "mcp__sequential" skills agents 2>/dev/null | wc -l | tr -d ' ')
echo "  'mcp__context7' occurrences: $mcp_context7 (target: extract to shared-refs)"
echo "  'mcp__github' occurrences: $mcp_github"
echo "  'mcp__tavily' occurrences: $mcp_tavily"
echo "  'mcp__sequential' occurrences: $mcp_sequential"
echo ""

# Large files needing attention
echo "=== Large Files (>200 lines) ==="
echo "Skills:"
find skills -name "SKILL.md" -exec wc -l {} + 2>/dev/null | awk '$1 > 200 && !/total/ {print "  " $0}'
echo "Agents:"
wc -l agents/*.md 2>/dev/null | awk '$1 > 200 && !/total/ {print "  " $0}'
echo "Commands:"
find commands -name "*.md" -exec wc -l {} + 2>/dev/null | awk '$1 > 200 && !/total/ {print "  " $0}'
echo ""

echo "=== Migration Progress ==="
echo "Phase 0: Pre-Migration - $(if git tag -l pre-migration | grep -q pre-migration; then echo "COMPLETE"; else echo "PENDING"; fi)"
echo "Phase 1: Shared References - $ref_count/20 files"
echo "Phase 2: Skills - $skills_with_composable/$skill_count standardized"
echo "Phase 3: Agents - $agents_with_expertise/$agent_count refactored"
echo "Phase 4: Commands - $((command_count - commands_over_100))/$command_count simplified"
echo ""

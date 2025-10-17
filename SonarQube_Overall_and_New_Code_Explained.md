# SonarQube: Overall Code vs New Code - A Comprehensive Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Overall Code](#overall-code)
3. [New Code](#new-code)
4. [Key Differences](#key-differences)
5. [How They Work Together](#how-they-work-together)
6. [New Code Period Definition](#new-code-period-definition)
7. [Quality Gate Strategy](#quality-gate-strategy)
8. [Best Practices](#best-practices)
9. [Common Use Cases](#common-use-cases)
10. [Examples](#examples)

## Introduction

SonarQube uses two primary perspectives to analyze code quality:
- **Overall Code**: The entire codebase, representing all code in your project
- **New Code**: Recently added or modified code, based on a defined period

Understanding these two concepts is crucial for implementing an effective code quality strategy and maintaining a clean codebase over time.

## Overall Code

### What is Overall Code?

**Overall Code** represents the complete state of your entire codebase at the time of analysis. It includes:
- All source files in the project
- All lines of code (including legacy code)
- All existing issues (bugs, vulnerabilities, code smells)
- Technical debt accumulated over the project's lifetime
- Code coverage across the entire project

### Metrics for Overall Code

SonarQube provides comprehensive metrics for Overall Code:

1. **Reliability** - Bugs in the entire codebase
2. **Security** - Vulnerabilities and Security Hotspots across all code
3. **Maintainability** - Code Smells throughout the project
4. **Coverage** - Overall test coverage percentage
5. **Duplications** - Percentage of duplicated code blocks
6. **Size** - Total lines of code, number of files, etc.
7. **Technical Debt** - Estimated time to fix all issues

### When to Focus on Overall Code

- **Initial project setup** - Understanding the complete state of code quality
- **Legacy code assessment** - Evaluating inherited technical debt
- **Long-term planning** - Setting strategic goals for code quality improvement
- **Portfolio management** - Comparing quality across different projects
- **Compliance reporting** - Demonstrating overall security and quality posture

## New Code

### What is New Code?

**New Code** refers to code that has been added or modified within a specified time period (the "New Code Period"). This concept is based on the principle that:

> "It's easier to prevent new issues than to fix old ones."

New Code includes:
- Recently added lines of code
- Modified existing code
- Changes introduced in recent commits
- Code changes since a specific version/tag/date

### Why New Code Matters

The New Code approach offers several advantages:

1. **Prevents Technical Debt Accumulation** - Stops issues from being introduced
2. **Focuses on Actionable Items** - Addresses problems developers just created
3. **Maintains Quality Standards** - Ensures new development meets quality bars
4. **Reduces Fix Costs** - Issues are fixed when context is fresh in developers' minds
5. **Enables Gradual Improvement** - Legacy code improves naturally through modifications

### Metrics for New Code

SonarQube tracks the same categories for New Code:

1. **New Bugs** - Bugs introduced in the new code
2. **New Vulnerabilities** - Security issues in new code
3. **New Code Smells** - Maintainability issues in new code
4. **Coverage on New Code** - Test coverage of recently added/modified code
5. **New Duplications** - Duplication density in new code
6. **New Technical Debt** - Estimated time to fix new issues

### When to Focus on New Code

- **Pull Request reviews** - Ensuring new contributions meet quality standards
- **Continuous Integration** - Failing builds when new code doesn't meet quality gates
- **Sprint/Release reviews** - Tracking quality of recent work
- **Developer feedback** - Providing immediate feedback on recent changes
- **Quality gate enforcement** - Preventing quality degradation

## Key Differences

| Aspect | Overall Code | New Code |
|--------|--------------|----------|
| **Scope** | Entire codebase | Recently added/modified code |
| **Purpose** | Understand complete quality state | Prevent new issues |
| **Timeline** | All project history | Defined period (e.g., last 30 days) |
| **Action Focus** | Strategic planning | Immediate fixes |
| **Quality Gate** | Optional/informational | Mandatory for most teams |
| **Issue Count** | Can be large (legacy) | Usually smaller (recent work) |
| **Improvement** | Gradual, requires dedicated effort | Immediate, part of normal development |
| **Developer Ownership** | Shared/unclear | Clear (recent authors) |

## How They Work Together

### The Clean As You Code Approach

SonarQube promotes the **"Clean As You Code"** methodology:

1. **Set Quality Standards** - Define quality gates for new code
2. **Enforce at PR/CI** - Block merges if new code doesn't meet standards
3. **Address New Issues** - Fix problems in new code immediately
4. **Gradual Legacy Improvement** - Old code improves when touched
5. **Maintain Quality** - Prevent backsliding

### Workflow Example

```
Developer makes changes → SonarQube analyzes → 
├─ Overall Code: Updated metrics (informational)
└─ New Code: Quality Gate check
    ├─ PASS → Merge allowed
    └─ FAIL → Must fix issues before merge
```

### Quality Evolution Over Time

**Month 1:**
- Overall: 5000 issues
- New Code: 0 issues (Quality Gate: PASS)

**Month 6:**
- Overall: 4500 issues (10% improvement from natural evolution)
- New Code: 0 issues (Quality Gate: PASS)

**Month 12:**
- Overall: 3800 issues (24% improvement)
- New Code: 0 issues (Quality Gate: PASS)

## New Code Period Definition

### Available Options

SonarQube offers several ways to define the New Code period:

#### 1. **Previous Version** (Recommended)
- New code = changes since the last version/release
- Best for release-based workflows
- Aligns with deployment cycles

```
Setting: "Previous version"
Example: Everything since v2.3.0 is "new code"
```

#### 2. **Number of Days**
- New code = changes in the last N days
- Useful for continuous deployment
- Example: Last 30 days

```
Setting: "30 days"
Example: Changes from Oct 1 - Oct 30 are "new code"
```

#### 3. **Specific Date**
- New code = changes since a specific date
- Good for one-time assessments
- Example: Since project start or major refactoring

```
Setting: "2024-01-01"
Example: All changes after January 1, 2024
```

#### 4. **Reference Branch**
- New code = differences from a reference branch (e.g., main/master)
- Ideal for feature branch workflows
- Enables PR-based quality gates

```
Setting: "Reference branch: main"
Example: Feature branch compared to main
```

### Configuration Levels

New Code periods can be set at:
- **Global** - Default for all projects
- **Project** - Specific to one project
- **Branch** - Specific to a branch (e.g., feature branch vs main)

## Quality Gate Strategy

### Typical Quality Gate Configuration

Most organizations use a **dual approach**:

#### For New Code (Strict - BLOCKING)
```
Condition                                  Threshold
--------------------------------------------------------
Coverage on New Code                       ≥ 80%
Duplicated Lines on New Code               ≤ 3%
Maintainability Rating on New Code         = A
Reliability Rating on New Code             = A
Security Rating on New Code                = A
Security Hotspots Reviewed                 = 100%
```

#### For Overall Code (Informational - NON-BLOCKING)
```
Condition                                  Threshold
--------------------------------------------------------
Coverage                                   ≥ 70% (warning)
Maintainability Rating                     ≤ B (warning)
Reliability Rating                         ≤ C (warning)
Security Rating                            ≤ C (warning)
```

### Rationale

- **New Code gates are strict** - Prevent technical debt from growing
- **Overall Code gates are lenient** - Acknowledge legacy but track improvement
- **Focus on prevention** - Easier than remediation

## Best Practices

### 1. Start with New Code Quality Gates
- Don't be overwhelmed by legacy issues
- Focus on preventing new problems
- Set achievable standards for new code

### 2. Define Appropriate New Code Period
- **Release-based projects**: Use "Previous version"
- **Continuous deployment**: Use "Number of days" (30-90 days)
- **Feature branches**: Use "Reference branch"

### 3. Make New Code Gates Mandatory
- Fail CI/CD pipeline if quality gate fails
- Require fixes before merging
- Make quality non-negotiable

### 4. Monitor Overall Code Trends
- Track improvement over time
- Set long-term goals
- Celebrate wins (e.g., 10% reduction in issues)

### 5. Address Security Issues Everywhere
- Don't wait for code to be "new" to fix vulnerabilities
- Security applies to both new and overall code
- Remediate critical security issues immediately

### 6. Clean As You Code
- When touching old code, improve it
- Leave code better than you found it
- Gradual improvement is sustainable

### 7. Adjust Thresholds Over Time
- Start with achievable goals
- Gradually tighten standards
- Aim for continuous improvement

### 8. Use Branch Analysis
- Analyze feature branches
- Catch issues before merge
- Enable early feedback

## Common Use Cases

### Use Case 1: Pull Request Quality Check

**Scenario**: A developer submits a PR with 50 lines changed

**SonarQube Analysis**:
- **Overall Code**: 5000 total issues (informational)
- **New Code**: 2 new code smells detected
- **Quality Gate**: FAILED (New code has issues)

**Action**: Developer fixes the 2 code smells, pushes update, quality gate passes, PR approved

---

### Use Case 2: Sprint Review

**Scenario**: Team reviews code quality for a 2-week sprint

**SonarQube Report**:
- **New Code Period**: Last 14 days
- **New Code Metrics**:
  - 0 new bugs ✓
  - 0 new vulnerabilities ✓
  - 3 new minor code smells (5 min debt)
  - 85% coverage on new code ✓
- **Overall Code**: 4800 issues (down from 5000)

**Outcome**: Team met quality standards, overall quality improved by 4%

---

### Use Case 3: Legacy Project Improvement

**Scenario**: Inherited project with 10,000 issues

**Strategy**:
1. **Week 1**: Set New Code quality gate (prevent new issues)
2. **Month 1-3**: Focus only on new code quality (gate: PASS)
3. **Month 4-6**: Address security vulnerabilities in overall code
4. **Month 7-12**: Refactor high-traffic modules (overall code improves naturally)

**Results**:
- New Code: Consistently 0 issues
- Overall Code: Reduced to 7,000 issues (30% improvement)
- Technical Debt: Reduced by 25%

---

### Use Case 4: Release Quality Assessment

**Scenario**: Preparing for v3.0 release

**SonarQube Configuration**:
- **New Code Period**: "Since v2.5" (previous version)

**Analysis**:
- **New Code in v3.0**:
  - 2500 new lines of code
  - 0 bugs ✓
  - 1 vulnerability (fixed) ✓
  - 92% test coverage ✓
- **Overall Code**:
  - Tracking improvement trends
  - Plan legacy cleanup for v3.1

**Decision**: v3.0 approved for release based on new code quality

## Examples

### Example 1: Understanding the Dashboard

**Overall Code Tab**:
```
Bugs: 45
Vulnerabilities: 12
Code Smells: 320
Coverage: 68.5%
Duplications: 5.2%
Technical Debt: 2d 4h
```
*This shows the complete state of your codebase*

**New Code Tab** (Last 30 days):
```
New Bugs: 0
New Vulnerabilities: 0
New Code Smells: 3
Coverage on New Code: 85%
New Duplications: 1.2%
Technical Debt on New Code: 15min
```
*This shows only what changed recently*

---

### Example 2: Quality Gate Evaluation

**Scenario**: CI/CD pipeline runs after commit

```
Overall Code Status: INFO
├─ 320 code smells (tracked)
├─ 68.5% coverage (below 70% goal)
└─ No blocking issues

New Code Status: FAILED ❌
├─ 3 new code smells found
│   └─ 2 × Cognitive Complexity too high
│   └─ 1 × Function too long
├─ Coverage: 85% ✓
└─ Must fix before merge
```

**Developer Action**: Refactor the 3 code smells, re-run analysis, quality gate passes ✓

---

### Example 3: Trend Analysis

**Monthly Report**:

| Month | Overall Issues | New Code Issues | Overall Trend |
|-------|---------------|-----------------|---------------|
| Jan   | 5000          | 0               | Baseline      |
| Feb   | 4950          | 0               | ↓ 1%          |
| Mar   | 4800          | 0               | ↓ 4%          |
| Apr   | 4500          | 0               | ↓ 10%         |
| May   | 4200          | 0               | ↓ 16%         |
| Jun   | 3900          | 0               | ↓ 22%         |

**Insight**: By maintaining new code quality at 0 issues, overall code quality improved 22% in 6 months through natural evolution.

---

## Conclusion

SonarQube's **Overall Code** and **New Code** concepts work together to provide:

1. **Complete Visibility** - Overall Code shows total state
2. **Actionable Focus** - New Code drives daily decisions
3. **Sustainable Improvement** - Prevent new issues while gradually improving legacy
4. **Developer Engagement** - Clear ownership and fast feedback
5. **Long-term Quality** - Strategic improvement without overwhelming teams

### Key Takeaways

✅ **Focus on New Code first** - It's the most impactful and achievable  
✅ **Make New Code quality gates mandatory** - Prevent technical debt growth  
✅ **Track Overall Code trends** - Monitor long-term improvement  
✅ **Choose the right New Code period** - Align with your workflow  
✅ **Clean As You Code** - Sustainable quality improvement  
✅ **Celebrate progress** - Acknowledge improvements in both metrics  

By understanding and leveraging both Overall Code and New Code perspectives, teams can build a culture of quality that balances pragmatism with excellence.

---

## Additional Resources

- [SonarQube Official Documentation](https://docs.sonarqube.org/)
- [Clean As You Code Methodology](https://docs.sonarqube.org/latest/user-guide/clean-as-you-code/)
- [Quality Gate Documentation](https://docs.sonarqube.org/latest/user-guide/quality-gates/)
- [New Code Definition](https://docs.sonarqube.org/latest/project-administration/new-code-period/)

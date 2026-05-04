# PARA Method Reference Guide

Detailed implementation guidance, platform-specific setups, and advanced techniques for the PARA organizational framework.

## Platform-Specific Implementation Guides

### Notion Implementation

#### Database Structure

```
Projects Database Properties:
├── Name (title)
├── Status (select: Planning, Active, On Hold, Completed)
├── Due Date (date)
├── Start Date (date)
├── Area (relation to Areas database)
├── Priority (select: P0, P1, P2, P3)
├── Progress (formula: checkbox completion %)
└── Notes (rich text)

Areas Database Properties:
├── Name (title)
├── Description (text)
├── Health Score (select: 🟢 Healthy, 🟡 Needs Attention, 🔴 Critical)
├── Active Projects (relation from Projects)
├── Key Metrics (text)
└── Last Review (date)

Resources Database Properties:
├── Name (title)
├── Topic Tags (multi-select)
├── Related Areas (relation)
├── Related Projects (relation)
├── Source (url)
├── Date Added (date)
└── Notes (rich text)
```

#### Notion Views to Create

```
Projects Views:
├── Active Projects (filter: Status = Active)
│   └── Sort by: Due Date ascending
├── By Area (group by: Area)
├── Timeline (calendar view)
└── Completed (filter: Status = Completed)

Areas Views:
├── All Areas (gallery view)
├── Needs Attention (filter: Health Score = 🟡 or 🔴)
└── By Health (group by: Health Score)

Resources Views:
├── By Topic (group by: Topic Tags)
├── Recently Added (sort by: Date Added descending)
└── Search (table view with search)
```

#### Notion Templates

**Project Template:**
```markdown
# 📋 {Project Name}

## Project Brief
**Status:** {Status}
**Timeline:** {Start Date} → {Due Date}
**Priority:** {Priority}
**Area:** {Area}

## 🎯 Goal
[What does "done" look like? Be specific and measurable]

## ✅ Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## 📝 Tasks
### Planning Phase
- [ ] Task 1
- [ ] Task 2

### Execution Phase
- [ ] Task 3
- [ ] Task 4

### Delivery Phase
- [ ] Task 5
- [ ] Task 6

## 📚 Resources Needed
Link to relevant Resource pages

## 📅 Milestones
- [ ] Milestone 1 - {Date}
- [ ] Milestone 2 - {Date}

## 🗒️ Notes & Progress Log
[Daily/weekly updates]

## 🔗 Links
- [Related documents]
- [External resources]
```

**Area Template:**
```markdown
# 📂 {Area Name}

## Definition
[What this area encompasses]

## Standards
What does "good enough" look like in this area?
- Standard 1
- Standard 2
- Standard 3

## 🎯 Goals (This Quarter)
1. Goal 1
2. Goal 2
3. Goal 3

## 📊 Key Metrics
| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Metric 1 | X | Y | 🟢/🟡/🔴 |

## 📋 Active Projects
[Database view showing related projects]

## 💡 Focus Areas
[What needs attention in this area]

## 📅 Review Schedule
- [ ] Weekly: Quick check-in
- [ ] Monthly: Deep dive
- [ ] Quarterly: Full review

## 🗒️ Notes
[Running thoughts and observations]

---
Last Review: {Date}
Health Score: {Score}
```

### Obsidian Implementation

#### Folder Structure

```
Obsidian Vault/
├── 1-Projects/
│   ├── 📋 MOC - Projects.md
│   ├── Project Name A/
│   │   ├── Project Brief.md
│   │   ├── Meeting Notes/
│   │   ├── Research/
│   │   └── Drafts/
│   └── Project Name B.md (simple project)
│
├── 2-Areas/
│   ├── 📋 MOC - Areas.md
│   ├── Health & Fitness.md
│   ├── Finances.md
│   ├── Career.md
│   └── Relationships.md
│
├── 3-Resources/
│   ├── 📋 MOC - Resources.md
│   ├── Marketing/
│   ├── Writing/
│   ├── Programming/
│   ├── Mental Models/
│   └── Book Notes/
│
├── 4-Archives/
│   ├── Completed Projects/
│   ├── Old Jobs/
│   └── Past References/
│
└── Templates/
    ├── Project Template.md
    ├── Area Template.md
    └── Resource Template.md
```

#### Dataview Queries

**Active Projects Query:**
```dataview
TABLE 
  status as "Status",
  due_date as "Due",
  area as "Area"
FROM "1-Projects"
WHERE status = "Active"
SORT due_date ASC
```

**Projects by Area:**
```dataview
TABLE 
  status as "Status",
  due_date as "Due"
FROM "1-Projects"
WHERE status = "Active"
GROUP BY area
```

**Recently Modified Resources:**
```dataview
TABLE 
  file.mtime as "Last Modified",
  topic as "Topic"
FROM "3-Resources"
SORT file.mtime DESC
LIMIT 10
```

**Area Health Dashboard:**
```dataview
TABLE 
  health_score as "Health",
  last_review as "Last Review",
  length(filter(projects, (p) => p.status = "Active")) as "Active Projects"
FROM "2-Areas"
SORT health_score ASC
```

#### Obsidian Templates (Core Plugin)

**Project Template:**
```markdown
---
title: {{title}}
status: Planning
area: 
due_date: 
priority: P2
created_date: {{date}}
tags: [project]
---

# 📋 {{title}}

## 🎯 Goal
[What does "done" look like?]

## ✅ Success Criteria
- [ ] 

## 📝 Tasks
- [ ] 

## 📚 Resources
- [[Link to relevant resources]]

## 🗒️ Notes
```

**Daily Note Integration:**
```markdown
---
date: {{date}}
---

## Today's Focus
- [ ] [[Project Link 1#Task]]
- [ ] [[Project Link 2#Task]]

## Meetings
- Meeting with X
  - Notes: [[Project Link 1#Meeting Notes]]

## Capture
Quick notes that need sorting later

## Log
What happened today
```

### Evernote / OneNote Implementation

#### Notebook Structure

```
Evernote Stack Structure:
┌─────────────────────────────────────┐
│ Stack: 1-PROJECTS                    │
├─────────────────────────────────────┤
│ 📓 Q4 Financial Report              │
│ 📓 Website Redesign                  │
│ 📓 Summer Vacation Planning          │
│ 📓 Client Presentation Prep          │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Stack: 2-AREAS                       │
├─────────────────────────────────────┤
│ 📓 Health & Fitness                  │
│ 📓 Finances                          │
│ 📓 Career Development                │
│ 📓 Relationships                     │
│ 📓 Home Maintenance                  │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Stack: 3-RESOURCES                   │
├─────────────────────────────────────┤
│ 📓 Marketing Strategies              │
│ 📓 Writing Tips                      │
│ 📓 Programming                       │
│ 📓 Design Inspiration                │
│ 📓 Productivity                      │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Stack: 4-ARCHIVES                    │
├─────────────────────────────────────┤
│ 📓 Completed Projects                │
│ 📓 Old Jobs                          │
│ 📓 Past Homes                        │
│ 📓 Inactive References               │
└─────────────────────────────────────┘

Special Notebooks:
┌─────────────────────────────────────┐
│ 📓 .Inbox (To Sort)                  │
│ 📓 Templates                         │
└─────────────────────────────────────┘
```

#### Tagging System

```
Project Tags:
#project/active
#project/planning
#project/on-hold
#project/completed-{year}

Area Tags:
#area/{area-name}
Example: #area/health, #area/finances

Resource Tags:
#resource/{topic}
Example: #resource/marketing, #resource/writing

Status Tags:
#status/urgent
#status/needs-review
#status/waiting

Context Tags:
#context/{context}
Example: #context/home, #context/work, #context/errands
```

### Apple Notes / Google Keep Implementation

#### Folder Structure (Apple Notes)

```
Root Folders:
├── 📁 1-Projects
│   ├── 📁 Active
│   │   ├── Note: Q4 Financial Report
│   │   └── Note: Website Redesign
│   └── 📁 Planning
│
├── 📁 2-Areas
│   ├── 📁 Health & Fitness
│   ├── 📁 Finances
│   ├── 📁 Career
│   └── 📁 Relationships
│
├── 📁 3-Resources
│   ├── 📁 Topics
│   └── 📁 Reference Materials
│
├── 📁 4-Archives
│   └── (yearly folders)
│
└── 📁 .Inbox
    └── (temporary holding)
```

#### Google Keep Structure

```
Label System:
📌 1-active (Projects)
📌 2-ongoing (Areas)
📌 3-reference (Resources)
📌 4-archive (Archives)

Color Coding:
🔴 Red = Projects
🟠 Orange = Areas
🟢 Green = Resources
⚫ Gray = Archives

Pin Strategy:
Pin important active projects
Unpin completed/deferred items
```

## Advanced Techniques

### Progressive Disclosure in PARA

```
Level 1: The Four Buckets
├── See only top-level folders
└── Quick categorization

Level 2: Active Work
├── Open Projects folder
├── See only active projects
└── Focus on what matters now

Level 3: Project Details
├── Open specific project
├── See tasks, notes, resources
└── Deep work on one project

Level 4: Cross-References
├── Links between projects/areas/resources
├── Discover connections
└── Holistic view
```

### PARA for Teams

#### Team Project Structure

```
Team PARA (Shared):

1-Projects/
├── Active Team Projects/
│   ├── Project Alpha/
│   │   ├── Brief.md
│   │   ├── Status.md
│   │   ├── Team Members.md
│   │   ├── Timeline.md
│   │   ├── Deliverables/
│   │   └── Meetings/
│   └── Project Beta/
├── Backlog Projects/
└── Completed/

2-Areas/
├── Team Operations/
├── Product Development/
├── Customer Success/
└── Growth & Marketing/

3-Resources/
├── Team Processes/
├── Brand Guidelines/
├── Technical Documentation/
└── Onboarding Materials/

4-Archives/
├── Past Projects/
├── Old Processes/
└── Historical Data/
```

#### Team Templates

**Team Project Template:**
```markdown
# Project: {Name}

## Overview
- **Status:** [Planning/Active/On Hold/Completed]
- **Owner:** [Primary responsible]
- **Team:** [Team members involved]
- **Timeline:** {Start} → {End}
- **Area:** [Which team area]

## 🎯 Goal
[What success looks like for the team]

## Success Metrics
- Metric 1: [Target]
- Metric 2: [Target]
- Metric 3: [Target]

## 📋 Milestones
| Milestone | Owner | Due Date | Status |
|-----------|-------|----------|--------|
| M1 | | | |

## 👥 Team Assignments
- {Person 1}: [Responsibility]
- {Person 2}: [Responsibility]

## 🗒️ Meeting Notes
### {Date} - {Meeting Name}
**Attendees:** [List]
**Decisions:**
- Decision 1
- Decision 2

**Action Items:**
- [ ] Action 1 - {Owner} - {Due}
- [ ] Action 2 - {Owner} - {Due}

## 🔗 Links
- [[Related Resources]]
- [[External Links]]
```

### PARA + Time Management

#### Daily Workflow

```
Morning Routine (5 min):
├── Open Projects folder
├── Review active projects
├── Identify 3 most important tasks
└── Link tasks to specific projects

During Day:
├── Capture ideas → .Inbox
├── Work on project tasks
├── Reference Resources as needed
└── Update project notes

End of Day (10 min):
├── Move completed tasks to Done
├── Update project status
├── Clear .Inbox → proper PARA location
└── Tomorrow's priorities
```

#### Weekly Review Checklist

```markdown
## Weekly PARA Review Template

### Projects Review (10 min)
- [ ] Review all active projects
- [ ] Update status for each project
- [ ] Archive completed projects
- [ ] Identify stalled projects
- [ ] Clarify next actions for each active project
- [ ] Check deadlines are realistic

### Areas Review (5 min)
- [ ] Quick scan of each area
- [ ] Identify neglected areas
- [ ] Note areas needing action
- [ ] Update area health scores

### Resources Review (5 min)
- [ ] Scan for misfiled items
- [ ] Check if anything should move to Projects/Areas
- [ ] Remove truly obsolete items

### Archives Review (5 min)
- [ ] Anything to permanently delete?
- [ ] Anything to reactivate?

### Inbox Clearing (5 min)
- [ ] Process all inbox items
- [ ] Sort into proper PARA location

### Next Week Planning (5 min)
- [ ] Define top 3 project priorities
- [ ] Schedule important tasks
- [ ] Block time for project work

---
Date: {Date}
Time Spent: {minutes}
Notes: {observations}
```

### PARA + Knowledge Management

#### Progressive Summarization Integration

```
Capture → Organize → Distill → Express

Capture Layer (Notes from sources):
├── Raw notes in .Inbox
└── Brief initial processing

Organize Layer (Move to PARA):
├── Determine where it belongs
├── Place in correct folder
└── Add basic metadata

Distill Layer (When actively using):
├── Highlight key passages
├── Summarize in own words
├── Extract key concepts
└── Link to active projects

Express Layer (Create output):
├── Apply to project work
├── Create new work
└── Archive final output

Implementation:
├── Keep raw notes in Resources
├── Create "Notes" files for ongoing distillation
├── Apply to active projects when needed
└── Final work lives in Projects → Archives
```

#### Linking Strategy

```
Cross-Category Linking:

Projects ←→ Resources:
├── Link relevant resources in project brief
├── Reference materials in project notes
└── Keep resources separate, link when needed

Areas ←→ Projects:
├── Projects support areas
├── List active projects in each area
└── Area goals inform project choice

Resources ←→ Resources:
├── Link related concepts
├── Build knowledge network
└── Use backlinks for discovery

All Categories ←→ Archives:
├── Move completed/inactive items
├── Maintain original structure
└── Link back to original location if needed
```

## Maintenance Workflows

### Project Completion Workflow

```
When a project is complete:

1. Final Documentation (15 min)
   ├── Write brief summary
   ├── List key outcomes
   ├── Document lessons learned
   ├── Note what worked / what didn't
   └── Archive important files/links

2. Clean Up (5 min)
   ├── Delete working drafts
   ├── Remove temporary notes
   ├── Keep final deliverables
   └── Organize remaining files

3. Move to Archives (2 min)
   ├── Create: Archives/Completed Projects/{Year}/{Project Name}
   ├── Move all project folders/files
   ├── Add date completed
   └── Tag as completed

4. Update Related Items (5 min)
   ├── Unlink from active areas
   ├── Update area project lists
   ├── Archive related tasks
   └── Celebrate completion! 🎉

Template for Archived Project:
```
# Project: {Name} (COMPLETED)

**Completion Date:** {Date}
**Original Timeline:** {Start} → {End}
**Final Status:** [Success/Partial/Not Met]

## Outcomes
[What was achieved]

## Key Deliverables
- Deliverable 1
- Deliverable 2

## Lessons Learned
- ✅ What worked
- ❌ What didn't work
- 💡 What to do differently

## Resources
[Links to final deliverables]

## Original Goal
[What was the initial goal]

## Success Criteria Met
- [ ] Criterion 1
- [ ] Criterion 2

---
Archived: {Date}
```
```

### Area Maintenance Workflow

```
Monthly Area Review:

For each Area:

1. Health Check (3 min/area)
   ├── Status: 🟢 Healthy / 🟡 Needs Attention / 🔴 Critical
   ├── Why this status?
   └── Quick fixes needed?

2. Project Alignment (2 min/area)
   ├── Are active projects serving this area?
   ├── Any projects completed that should be archived?
   ├── New projects needed?
   └── Update project list

3. Metrics Review (2 min/area)
   ├── Update metrics if tracked
   ├── Compare to standards
   └── Identify trends

4. Action Items (3 min/area)
   ├── What needs attention this month?
   ├── Schedule necessary actions
   └── Set reminders

5. Resources Check (1 min/area)
   ├── Need any reference materials?
   └── Relevant new resources to add?

Total: ~30-45 minutes for all areas
```

### Resource Curation Workflow

```
Quarterly Resource Audit:

1. Topic Review (10 min)
   ├── Scan all resource folders
   ├── Identify topics to merge
   ├── Note gaps in knowledge base
   └── Remove truly obsolete topics

2. Quality Check (15 min)
   ├── Review top 10 most accessed resources
   ├── Are they still valuable?
   ├── Need updates?
   └── Link to current projects/areas?

3. Consolidation (10 min)
   ├── Merge duplicate resources
   ├── Create MOCs (Maps of Content) for large topics
   ├── Link related resources
   └── Delete outdated versions

4. Reorganization (10 min)
   ├── Rename clearly
   ├── Restructure if needed
   ├── Update tags/links
   └── Simplify navigation

5. Gap Filling (Ongoing)
   ├── Note missing topics during work
   ├── Add to acquisition list
   └── Schedule research time
```

## Troubleshooting Deep Dives

### Problem: System Becomes Static

```
Symptoms:
├── Notes sit untouched for months
├── Projects never complete
├── Areas feel stagnant
└── Resources never referenced

Diagnosis:
├── Over-organizing at setup
├── Not linking items across categories
├── Skipping regular reviews
└── Hoarding vs. curating

Solutions:
├── Daily: Open PARA during work
├── Link actively during capture
├── Schedule review time (non-negotiable)
├── Delete/aggressively prune
├── Focus on active use, not perfect organization
└── Start projects from resources (apply knowledge)

Practice: The "Touch Rule"
Every time you touch an item:
├── Update it
├── Link it
├── Move it to correct location
└── Or delete it
```

### Problem: Projects Bleed Into Areas

```
Symptoms:
├── Projects without clear endpoints
├── "Ongoing projects" that never end
├── Confusion between P and A
└── Projects folder becomes permanent

Diagnosis:
├── Mislabeled ongoing work
├── Fear of completion
├── Projects that are actually habits
└── Missing success criteria

Solutions:

1. The Deadline Test:
   Can you put a date on the calendar for completion?
   YES → Project
   NO → Area

2. The Completion Test:
   Would you throw a party when this is done?
   YES → Project
   NO → Area

3. The Success Test:
   Can you clearly define "done"?
   YES → Project
   NO → Area

Example Conversions:

❌ Project: "Be healthier" (no endpoint)
✅ Area: "Health & Fitness"
   Project: "Run a 5k by June"

❌ Project: "Learn Spanish" (ongoing)
✅ Area: "Language Learning"
   Project: "Complete Spanish Module 1 by March"

❌ Project: "Write more" (vague)
✅ Area: "Writing & Content Creation"
   Project: "Publish article by Friday"

Action: Review Projects list → convert to Areas if no clear endpoint
```

### Problem: Resources Never Used

```
Symptoms:
├── Huge Resources folder
├── Never reference saved items
├── Hoarding articles/tutorials
└── FOMO-driven saving

Diagnosis:
├── Saving "just in case" (future FOMO)
├── Not connecting to active work
├── Too much, too disorganized
└── No review process

Solutions:

1. The Utility Test:
   "Will I use this in the next 3 months?"
   └── If not, delete or don't save

2. Link to Projects/Areas:
   ├── Every saved resource should support active work
   ├── Add "Related Project" field
   ├── Review during project planning
   └── Reference in project notes

3. Progressive Summarization:
   Don't save entire articles:
   ├── Highlight key passages
   ├── Write summary in your own words
   ├── Extract actionable insights
   └── Delete original if fully processed

4. Regular Pruning:
   Monthly:
   ├── Delete unused resources
   ├── Merge duplicates
   ├── Update outdated info
   └── Keep lean

The 20% Rule:
You'll only use ~20% of saved resources.
Focus on:
├── Quality over quantity
├── Actionable over interesting
├── Current over comprehensive
└── Linked over isolated
```

### Problem: Archive Becomes Dumping Ground

```
Symptoms:
├── Archives grows endlessly
├── Everything gets "archived just in case"
├── Archive never used for reference
└── Digital hoarding

Diagnosis:
├── Difficulty letting go
├── Fear of needing it later
├── No delete criteria
└── Archive = graveyard mindset

Solutions:

1. The Archive Test:
   "Will I realistically need this again?"
   ├── If no: DELETE
   └── If yes: Archive

2. The Value Test:
   "Does this have historical or sentimental value?"
   ├── If no: DELETE
   └── If yes: Archive

3. Time-Based Archiving:
   - Active: Used regularly
   - Dormant: Not used in 6 months (consider delete)
   - Archive: Completed/inactive but valuable
   
   Set reminders:
   ├── Quarterly: Review archive
   ├── Yearly: Major cleanup
   └── Keep archive lean

4. Compression:
   Don't keep everything:
   ├── Keep final deliverables
   ├── Keep key documents
   ├── Delete working drafts
   ├── Delete duplicates
   └── Summarize large folders

5. Cost-Benefit Analysis:
   Storage is cheap, but:
   ├── Mental load is real
   ├── Search becomes harder
   ├── Important items get buried
   └── Maintenance time increases
   
   Better to have lean, searchable archive

Delete with Confidence:
── Fear: "What if I need it?"
── Reality: You probably won't
── And if you do: It's likely available elsewhere
── Trust future-you to find it again
```

## Integration Examples

### PARA + Bullet Journal

```
Bullet Journal Index (Monthly):
Page 1-2: Monthly Index

Collections (like Resources):
├── Habit Tracker
├── Goals Page
├── Project Lists

Daily Log (Active Work):
├── Tasks (link to Projects/Areas)
├── Notes (capture for later sorting)
└── Events (calendar)

Weekly Spread:
├── Review of last week
├── Migration of tasks
├── PARA folder review
└── Next week planning

Mapping:
Projects → Active Tasks (marked •)
Areas → Goals/Habits
Resources → Collections
Archives → Old Monthly Logs
```

### PARA + Calendar

```
Calendar Integration:

Projects:
├── Block time for project work
├── Set deadlines
├── Schedule milestones
└── Meeting notes → project folders

Areas:
├── Regular review meetings (weekly/monthly)
├── Recurring time blocks (gym, date night, etc.)
└── Health appointments, finance reviews

Resources:
├── Learning time blocks
├── Research sessions
└── Reading time

Weekly Review (Calendar Event):
Title: "Weekly PARA Review"
Time: Sunday evening, 30 min
Recurring: Weekly
Location: Project folder / Inbox
Description:
- Projects status
- Areas health check
- Resources scan
- Archive cleanup
```

### PARA + Task Manager (Todoist, Things, etc.)

```
Task Manager Structure:

Today (default)
├── Pull from active projects
└── Focus on top 3 priorities

Projects:
├── One project per PARA project
├── Tasks linked to project goals
└── Due dates = project deadlines

Areas (as Areas of Responsibility):
├── Health & Fitness
├── Finances
├── Career
├── Relationships
└── Ongoing habits/tasks

Resources:
├── No tasks usually
├── Maybe: "Read X" or "Review Y"
└── Scheduled learning time

Upcoming:
├── Future project tasks
├── Scheduled area tasks
└── Someday/Maybe → Archive

Inbox:
├── Quick capture
└── Sort to PARA during review
```

## Success Metrics

### PARA Health Indicators

```
Healthy PARA System:

Projects (Active & Focused):
├── 5-15 active projects
├── Each has clear goal & deadline
├── Regular progress visible
├── Completed projects archived promptly
└── No stalled projects older than 1 month

Areas (Maintained & Balanced):
├── All areas have defined standards
├── Each area receives attention
├── Health scores updated
└── Active projects support areas

Resources (Useful & Connected):
├── Referenced during active work
├── Links to projects/areas
├── Regularly reviewed/pruned
└── Quality over quantity

Archives (Lean & Searchable):
├── Completed projects archived
├── Easy to find past work
├── Archived when truly inactive
└── Regular cleanup (quarterly)

System Flow:
├── Weekly reviews completed
├── Items flow P → A → R → Archive
├── Easy to find anything in <30 seconds
└── System reduces stress, not adds it
```

### Red Flags

```
Unhealthy PARA System:

Projects:
├── >20 active projects (overwhelmed)
├── Projects without deadlines (not projects)
├── Projects older than 3 months with no progress
└── No completed projects in last month

Areas:
├── Areas undefined or missing
├── Some areas completely neglected
├── No connection to projects
└── No standards or metrics

Resources:
├── Never accessed items
├── Massive unorganized collections
├── No links to active work
└── Hoarding behavior

Archives:
├── Everything gets archived (nothing deleted)
├── Archive never reviewed
├── Can't find past work
└── Archive grows indefinitely

System Issues:
├── Weekly reviews skipped
├── Can't find items quickly
├── System feels like a burden
├── Spend more time organizing than using
└── PARA folders ignored during work
```

## Quick Reference Tables

### Category Comparison

| Aspect                | Projects                      | Areas                       | Resources                      | Archives                  |
| --------------------- | ----------------------------- | --------------------------- | ------------------------------ | ------------------------ |
| **Has endpoint?**     | Yes                           | No                          | No                             | N/A                      |
| **Has deadline**      | Yes                           | No                          | No                             | N/A                      |
| **Actionability**     | High (active now)             | High (ongoing)              | Low (reference)                | None (inactive)          |
| **Example**           | Launch website                | Health & Fitness            | Marketing strategies           | Old job files            |
| **When complete**     | Archive it                    | Never complete              | Delete or keep                 | Delete or keep           |
| **Review frequency**  | Weekly                        | Monthly                     | As needed                      | Quarterly                |
| **Structure**         | One folder per project        | One folder per area         | Topic-based folders            | Date/category folders    |
| **Contains**          | Tasks, notes, deliverables    | Standards, metrics, links   | Notes, references, inspiration | Completed/inactive items |

### Categorization Examples

| Item                                    | Category      | Why?                                         |
| --------------------------------------- | ------------- | -------------------------------------------- |
| "Complete Q4 report by Dec 15"         | Project       | Has endpoint, deadline, active              |
| "Financial health"                      | Area          | Ongoing responsibility, no endpoint          |
| "Marketing strategies document"         | Resource      | Reference material, potential future use     |
| "2023 tax returns"                      | Archive       | Past, completed, historical record           |
| "Plan summer vacation"                  | Project       | Specific goal, has endpoint                  |
| "Travel"                                | Area/Resource | Area if traveling regularly, Resource if not |
| "Health & Fitness"                      | Area          | Ongoing responsibility                       |
| "Lose 10 lbs by June"                   | Project       | Specific goal, deadline, supports Area       |
| "Article notes on productivity"         | Resource      | Reference material                           |
| "Notes from 2020 conference"            | Archive       | Past event, inactive                         |
| "Learn to code"                         | Area          | Ongoing development                          |
| "Complete JavaScript course by March"   | Project       | Specific course, has deadline               |
| "JavaScript tutorials collection"       | Resource      | Reference materials for learning             |

This reference guide provides detailed implementation strategies across platforms, advanced techniques, maintenance workflows, and troubleshooting solutions for the PARA method.
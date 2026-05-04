---
name: value-realization
description:
  Analyze if end users discover clear value. Use when evaluating product concepts, analyzing adoption, or uncertain about direction.
---

This skill provides a comprehensive framework for evaluating whether end users can "know" what value they'll achieve through a product. It combines analytical methods with decision-making guidance to help you assess product ideas, identify improvement opportunities, and take action.

**What this skill provides**:
- Four-dimension analysis framework (Clarity, Timeline, Perception, Discovery)
- Assessment rubrics for each dimension with scoring guidance
- Decision framework for taking action based on analysis
- B2B/B2E enterprise context guidance
- Prioritization guidance for different product types
- User segmentation by journey stage and persona
- Success criteria and actionable outputs

**Core question**: Can end users clearly understand what value they'll achieve through the product - even if that value takes time to achieve?

**Key terminology**:
- **User**: You (product creator, PM, designer, entrepreneur, etc.)
- **End user**: The person who will use the product being discussed
- **Value**: The outcomes end users achieve (identity, financial gain, capability, time savings, etc.)
- **Features**: The product's technical capabilities

**Core distinction**: Features are not value - features are what the product can do, value is what end users achieve.

## Analysis Framework: Four Dimensions

When analyzing a product idea, evaluate these four dimensions systematically:

### Dimension 1: Value Clarity

**Examine**: Can end users articulate what they'll achieve?

**Why it matters**: End users won't adopt a product if they can't explain to themselves (or others) why they're using it.

**Examples**:
- ✅ **Dropbox**: "Access my files from any device" (clear outcome)
- ❌ **Google Wave**: "Unified communication" (vague, abstract)

**Assessment Rubric**:

| Score | Criteria | Description |
| ----- | -------- | ----------- |
| 🔴 **1** | Fragmented | End users cannot explain what they'll achieve; describe features only |
| 🟡 **2** | Partial | End users can explain but struggle to communicate to others; vague wording |
| 🟢 **3** | Clear | End users clearly articulate what they'll achieve; can explain to others |
| 🟢 **4** | Crisp | End users describe value in one concrete sentence anyone understands |

### Dimension 2: Value Timeline

**Examine**: Is value immediate or delayed? What's the appropriate timeline for this product?

**Three design options** (all are valid):

| Approach | Best For | Examples |
| -------- | ------- | -------- |
| **Pure short-term** | Tool-type products, utility apps | Zoom (join meeting), Stripe (test payment) |
| **Pure long-term** | Transformational goals, committed users | Fitness apps (body change), Investment apps (wealth building) |
| **Hybrid** | Long-term goal requiring engagement | Duolingo (fluency with streaks, XP) |

**Assessment Rubric**:

| Score | Criteria | Description |
| ----- | -------- | ----------- |
| 🔴 **1** | Mismatched | Timeline conflicts with end user expectations (e.g., long-term product marketed as immediate) |
| 🟡 **2** | Unclear | Timeline undefined; end users don't know when to expect value |
| 🟢 **3** | Aligned | Timeline matches product nature and end user expectations |
| 🟢 **4** | Optimized | Timeline intentionally designed with engaging touchpoints |

### Dimension 3: Value Perception

**Examine**: Can end users see/feel what they achieved?

**Why it matters**: Invisible value feels like no value. Progress must be perceivable.

**Examples**:
- ✅ **Visible outcomes**: File sync status (Dropbox), likes count (Instagram), contribution graph (GitHub)
- ❌ **Invisible outcomes**: "Your data is synced", "Security improved", "Algorithm optimized"

**Assessment Rubric**:

| Score | Criteria | Description |
| ----- | -------- | ----------- |
| 🔴 **1** | Invisible | End users cannot see any evidence of value; changes are completely abstract |
| 🟡 **2** | Opaque | Value delivered but not shown; requires digging to find evidence |
| 🟢 **3** | Visible | End users can see progress; value has tangible manifestations |
| 🟢 **4** | Salient | Value is prominently displayed; end users are constantly reminded of achievements |

### Dimension 4: Value Discovery

**Examine**: Do end users already know they want this, or will they discover it through use?

**Why it matters**: Sometimes end users don't know what they want until they experience it. The product must enable rapid discovery.

**Discovery patterns**:
- ✅ **Instagram**: End users thought they wanted "share photos", discovered they valued "become a photographer" (identity)
- ✅ **Notion**: End users thought they wanted "take notes", discovered they valued "become organized" (identity)

**Assessment Rubric**:

| Score | Criteria | Description |
| ----- | -------- | ----------- |
| 🔴 **1** | No path | Discovery possible but no clear onboarding; end users struggle to find value |
| 🟡 **2** | Slow path | Aha moment exists but takes too long (weeks/months) to reach |
| 🟢 **3** | Fast path | Most end users discover value within first session |
| 🟢 **4** | Accelerated | Discovery actively guided through tutorial, onboarding, or progressive revelation |

## Progressive Disclosure

This skill provides detailed examples through context files. Load them when needed:

| Context File                    | When to Load                                    |
| ------------------------------- | ----------------------------------------------- |
| `context/decision-flow.md`      | Scoring trade-offs, journey stage analysis, ready-to-ship criteria |
| `context/enterprise-guide.md`   | B2B/B2E products with separate buyer/end-user analysis |
| `context/examples.md`            | Real-world success/failure case studies (Dropbox, Duolingo, Instagram, Google Wave, Quibi) |

## Decision Framework

### Overall Score Calculation

Score = Sum of dimension scores / 4

- **1.0-1.5**: Critical (immediate action)
- **2.0-2.5**: Needs work (priority improvements)
- **3.0-3.5**: Good (iterate and optimize)
- **4.0**: Excellent (maintain momentum)

### Priority Improvements (Score 2.0-2.8)

**If Value Clarity is 🔴 or 🟡 (priority #1)**:
- Rewrite value propositions using "outcome, not feature" framing
- Run 5-second tests with 10 target users
- Success: 80%+ can explain the value

**If Value Timeline is mismatched (priority #2)**:
- Align timeline with end user expectations

**If Value Perception is 🔴 or 🟡 (priority #3)**:
- Make progress visible with dashboards, notifications, progress indicators

**If Value Discovery is 🔴 or 🟡 (priority #4)**:
- Accelerate time-to-aha
- Map user journey from signup to value realization

## Product Type Matrix

| Product Type | Clarity | Timeline | Perception | Discovery | Notes |
| ------------ | ------- | -------- | ---------- | --------- | ----- |
| **Social apps** | High | Medium | Medium | High | Identity discovery critical |
| **Productivity tools** | High | High | High | Medium | Utility must be immediate and visible |
| **Infrastructure/Dev tools** | Medium | High | High | Medium | Perception > Clarity (technical users) |
| **Gaming/Entertainment** | Medium | High | High | High | Engagement loops matter |
| **Enterprise B2B** | Medium | Medium | High | Low | Decision-maker evaluation different |
| **Marketplaces/Platforms** | High | High | Medium | Medium | Trust signals and outcomes |

## Common Pitfalls

### Pitfall 1: One-Dimension Fixes

**Mistake**: Fixing only one dimension (e.g., clarity) and ignoring others.

**Reality**: Weak perception undermines even excellent clarity.

**Avoid**: Always evaluate all four dimensions.

### Pitfall 2: Feature-Centric Messaging

**Mistake**: Listing features instead of outcomes.

**Reality**: End users don't care about "X feature," they care about "achieve Y."

**Avoid**: Use "feature name → end user outcome" mapping for all messaging.

### Pitfall 3: Timeline Mismatch

**Mistake**: Long-term product marketed as immediate (or vice versa).

**Reality**: Timeline mismatch creates end user frustration and churn.

**Avoid**: Clearly communicate timeline. If long-term, explain what short-term touchpoints exist.

### Pitfall 4: Invisible Value

**Mistake**: Delivering great value that end users can't see.

**Reality**: Invisible = no value in end user perception.

**Avoid**: Always ask "Can end users point to something and say 'I achieved this'?"

### Pitfall 5: Ignoring Discovery Path

**Mistake**: Assuming end users will "figure it out."

**Reality**: Most won't take time to discover value through trial and error.

**Avoid**: Explicitly design the "aha moment" journey from signup to realization.

### Pitfall 6: B2B Focusing Only on Buyers

**Mistake**: Enterprise products that sell to CIOs but fail with end users.

**Reality**: If employees won't use it, the deal won't renew.

**Avoid**: Separate buyer analysis from end user analysis; both must succeed. See `context/enterprise-guide.md`.

## How to Use This Skill

### When to Engage

Trigger this skill when:
- Discussing product ideas or features
- Evaluating "is this idea good?"
- Analyzing adoption or retention problems
- Planning marketing or positioning strategy
- Uncertain about product direction

### Engagement Process

1. **Identify end users** - Who will use the product?
2. **Complete four-dimension analysis** - Evaluate clarity, timeline, perception, discovery
3. **Determine product type** - Consumer, B2B, enterprise?
4. **Apply scoring and decision framework** - Score → Identify priorities → Plan actions
5. **Document findings** - Summary, decisions, action plan

### Key Principles

1. **End users must "know" what value they'll achieve** - even if delayed
2. **Value types are diverse** - identity, money, benefits, status, capability, and more
3. **End users often don't know what they want** - help them discover it
4. **Perception matters** - invisible value = no value
5. **Context is everything** - patterns from one product may not apply to others
6. **Both short-term and long-term are valid** - neither superior, choose based on product nature
7. **Test with real end users** - don't assume
8. **Score all dimensions** - trade-offs OK, ignoring dimensions not

## Integration with Other Skills

| Skill | Combined Use |
| ----- | ----------- |
| **Jobs-to-be-Done** | Analyze what jobs end users are hiring the product to do |
| **Making Product Decisions** | Document value realization analysis decisions |
| **Five Whys** | Dig into why end users struggle with specific dimensions |
| **Hypothesis Tree** | Structure value discovery hypotheses to test |

## Remember

This skill helps analyze and make decisions, not prescribe solutions. Every product is unique. Every market is different. The goal: discover whether end users will clearly understand what they'll achieve - because that understanding drives adoption.

**When in doubt**: Test with real end users. Framework guides thinking; reality validates it.
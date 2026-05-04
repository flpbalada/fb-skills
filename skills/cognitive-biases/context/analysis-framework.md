# Cognitive Bias Analysis Framework

Step-by-step process for analyzing and improving products using cognitive bias principles.

## Step 1: Identify Decision Points

Map where users make decisions:

```
User Journey Decision Points:

Landing Page
├── Stay or bounce?           [Availability, Social Proof]
├── Which CTA to click?       [Framing, Anchoring]
│
Signup
├── Email or social login?    [Convenience, Trust]
├── Share optional data?      [Reciprocity]
│
Pricing
├── Which plan?               [Anchoring, Decoy]
├── Monthly or annual?        [Loss Aversion]
│
Onboarding
├── Complete or skip?         [Commitment, Sunk Cost]
├── Invite teammates?         [Social Proof]
│
Retention
├── Continue or churn?        [Sunk Cost, Loss Aversion]
└── Upgrade or stay?          [Anchoring, Social Proof]
```

## Step 2: Map Current Bias Usage

Audit existing design:

| Screen    | Decision       | Bias Used     | Ethical? | Effective? |
| --------- | -------------- | ------------- | -------- | ---------- |
| Pricing   | Plan selection | Anchoring     | ✅       | ✅         |
| Checkout  | Add extras     | Scarcity      | ⚠️ Fake  | ❌         |
| Trial end | Convert        | Loss aversion | ✅       | ✅         |

## Step 3: Design Improvements

For each decision point:

```
Decision: Plan selection

Current state:
- Plans listed low to high
- No default highlighted
- Equal visual weight

Improved design:
- Anchor with Enterprise first (Anchoring)
- "Most popular" badge on target plan (Social Proof)
- "Recommended for you" personalization (Confirmation)
- Annual savings calculated (Loss Aversion)
```

## Output Template

After completing analysis, document as:

```markdown
## Cognitive Bias Analysis

**Product/Feature:** [Name]

**Analysis Date:** [Date]

### Decision Point Audit

| Decision Point | Current Biases | Ethical Assessment | Recommendations |
| -------------- | -------------- | ------------------ | --------------- |
| [Point 1]      | [Biases used]  | [✅/⚠️/❌]         | [Changes]       |
| [Point 2]      | [Biases used]  | [✅/⚠️/❌]         | [Changes]       |

### Recommended Improvements

#### High Priority

- [Improvement 1]: Apply [bias] at [location] to [effect]
- [Improvement 2]: Remove [dark pattern] from [location]

#### Medium Priority

- [Improvement 3]
- [Improvement 4]

### Ethical Checklist

- [ ] All scarcity claims are factual
- [ ] Users can easily reverse decisions
- [ ] No exploitation of vulnerable states
- [ ] Transparent about pricing and terms
- [ ] Personalization is controllable

### Success Metrics

| Metric            | Current | Target | Measurement   |
| ----------------- | ------- | ------ | ------------- |
| Conversion rate   | X%      | Y%     | Analytics     |
| User satisfaction | X       | Y      | Survey        |
| Regret rate       | X%      | <Y%    | Cancellations |
```

## Integration with Other Methods

| Method              | Combined Use                            |
| ------------------- | --------------------------------------- |
| **Five Whys**       | Why do users behave unexpectedly?       |
| **Graph Thinking**  | Map bias influences across user journey |
| **Business Canvas** | Bias impact on value proposition        |
| **Jobs-to-be-Done** | Align bias use with user goals          |
| **A/B Testing**     | Validate bias effectiveness ethically   |
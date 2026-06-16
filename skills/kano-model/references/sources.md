# Kano Model Sources

Use this reference when citing sources, designing surveys, mapping answers, or calculating Kano outputs.

## Core Sources

- Wikipedia, "Kano model": overview, category definitions, paired functional/dysfunctional questionnaire, sample answer mapping, and QFD/product-specification use. https://en.wikipedia.org/wiki/Kano_model
- Kano, Noriaki; Seraku, Nobuhiku; Takahashi, Fumio; Tsuji, Shinichi. "Attractive quality and must-be quality." Journal of the Japanese Society for Quality Control, 14(2), 39-48, April 1984. Cited by Wikipedia as original model source.
- KanoSurveys.com, "Kano analysis techniques made simple": practical analysis methods, modal categorization, continuous analysis, and satisfaction coefficient formulas. https://www.kanosurveys.com/articles/kano-analysis
- Binder, Michelle; Vogt, Annika; Bajraktari, Adrian; Vogelsang, Andreas. "Automatically Classifying Kano Model Factors in App Reviews." arXiv:2303.03798, 2023. Useful caveat for software: app reviews can be classified, but missing context limits accuracy. https://arxiv.org/abs/2303.03798
- Ishak, Aulia; Ginting, Rosnani; Suwandira, Bayu; Malik, Alfin Fauzi. "Integration of Kano Model and Quality Function Deployment (QFD) to Improve Product Quality: A Literature Review." IOP Conference Series: Materials Science and Engineering, 1003, 012025, 2020. Useful for Kano + QFD connection. https://doi.org/10.1088/1757-899X/1003/1/012025

## Category Test

Classify by satisfaction asymmetry:

| Category | If present | If absent | Product action |
| --- | --- | --- | --- |
| Must-be | Neutral or expected | Dissatisfied | Protect baseline |
| One-dimensional | Satisfied | Dissatisfied | Improve if strategic |
| Attractive | Satisfied or delighted | Neutral | Use for differentiation |
| Indifferent | Neutral | Neutral | Cut or defer |
| Reverse | Dissatisfied | Satisfied or relieved | Remove, segment, or make optional |
| Questionable | Contradictory | Contradictory | Exclude or inspect |

## Survey Mapping

Common answer-pair examples:

| Functional answer | Dysfunctional answer | Category |
| --- | --- | --- |
| I expect it | I dislike it | Must-be |
| I like it | I dislike it | One-dimensional |
| I like it | I am neutral | Attractive |
| I am neutral | I am neutral | Indifferent |
| I dislike it | I expect it | Reverse |

Treat "I like it" for both present and absent, or similarly inconsistent responses, as questionable.

## Analysis Options

- Discrete category: classify each respondent, count categories, use modal category. Good for fast decisions; weak when winner is narrow.
- Distribution view: show all category counts. Use when segments disagree or reverse responses matter.
- Satisfaction coefficients: rank features inside similar categories.

Formulas:

```text
total = attractive + one_dimensional + must_be + indifferent
better = (attractive + one_dimensional) / total
worse = -1 * (one_dimensional + must_be) / total
```

Exclude reverse and questionable responses from coefficient denominator unless deliberately running a sensitivity check.

## Interpretation Notes

- Better near 1: strong upside if feature is present.
- Worse near -1: strong downside if feature is absent.
- High attractive plus low worse: optional delighter.
- High must-be plus high negative worse: baseline requirement.
- Strong reverse count: likely segment split, unwanted complexity, or feature control problem.
- Old delighters can become performance factors or must-haves as markets mature.

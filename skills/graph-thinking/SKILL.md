---
name: graph-thinking
description:
  Apply graph-based thinking to visualize complex relationships and solve
  problems non-linearly. Use when mapping dependencies, analyzing systems,
  exploring interconnected concepts, or designing architectures.
---

# Graph Thinking

Model a problem as nodes and relationships.
Use it when linear lists hide dependencies.

## When to use

- Dependency mapping.
- System architecture.
- Stakeholder relationships.
- Concept maps.
- Recommendation or knowledge graph design.
- Complex product or process analysis.

## Goal

- Identify important nodes.
- Name relationships.
- Find clusters, bottlenecks, loops, and paths.
- Turn structure into decisions.

## Concepts

- Node: item, person, system, idea, or constraint.
- Edge: relationship between nodes.
- Cluster: tightly connected group.
- Path: route through graph.
- Centrality: importance by connectedness.
- Loop: circular dependency or feedback.

## Edge types

- Dependency: A requires B.
- Influence: A affects B.
- Conflict: A competes with B.
- Synergy: A improves B.
- Flow: A sends value, data, or work to B.

## Rules

- Do not connect everything to everything.
- Name edge types.
- Mark edge strength when useful.
- Look for missing nodes.
- Look for critical paths.
- Prefer simple diagrams over dense tables.

## Flow

1. Define subject and decision to support.
2. List nodes.
3. Group nodes by category.
4. Add typed edges.
5. Identify central nodes, clusters, loops, and bottlenecks.
6. Trace key paths.
7. Recommend actions.

## Resources

- [Graph of Thoughts: ArXiv Paper](https://arxiv.org/abs/2308.09687)
- [Neo4j Graph Database Use Cases](https://neo4j.com/use-cases/)
- [Network Science by Albert-László Barabási](http://networksciencebook.com/)

## Output

```md
## Graph Analysis

Subject: [what is being mapped]

## Nodes
- [category]: [nodes]

## Relationships
- [A] -> [B]: [edge type], [strength]

## Patterns
- Central nodes: [nodes]
- Clusters: [groups]
- Bottlenecks: [nodes]
- Loops: [loops or none]
- Critical paths: [paths]

## Recommendations
- [action]
- [action]
```

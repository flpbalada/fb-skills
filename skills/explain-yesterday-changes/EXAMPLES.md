# Examples

```md
- Payload live preview was added/expanded for `Pages` and `Blog`.
- Editors can preview saved/autosaved drafts through a secret-protected preview flow.
- Payload `Pages` now use draft/version support for live preview.
- Seeded pages were fixed so they remain visible in Payload Admin with tenant filtering.
- Migrated Payload documents are now published/repairable so Admin and public reads see the same migrated content.
- Page parent hierarchy was added as the source for canonical nested routes.
- Nested page URLs, sitemap links, metadata, search links, navigation links, and preview URLs now use canonical paths.
- Shallow duplicate page URLs now redirect to the canonical nested URL where possible.
- New CMS migration/rebind tools were added for parent-page audit, draft-version integrity, and publish-status verification.
- Rebind script aliases were added to make migration repair/check flows easier to run.
- The temporary routed-document summary field/component was removed from Payload Admin.
- Payload-mode rendering and navigation were tightened around canonical links, buttons, header links, search results, and page paths.
- Playwright setup was improved so managed web-server tests use an isolated port.
- Form API route coverage was added for `career` and `send-mail`.
- Documentation/PRDs were added for live preview, page parent routes, draft-version visibility, publish repair, builder smoke debt, and script usage.
```

```md
- Product editors can now manage product badges directly in Admin.
- Product listing pages now show active badges next to eligible products.
- Badge visibility respects publish status, date limits, and tenant filtering.
- Product detail pages now use the same badge labels as product listings.
- Admin validation was added so duplicate badge slugs cannot be saved.
- The product import tool now keeps existing badge assignments when updating products.
- The product export now includes badge names for easier editorial review.
- Search results now include badge labels where products are shown.
- Empty badge states were cleaned up so editors see clearer Admin messages.
- Documentation was added for badge setup, badge publishing, and product import behavior.
```

```md
- Blog editors can now schedule posts for future publication.
- Scheduled posts stay hidden from public blog pages until their publish time.
- Admin now shows clearer publish status for draft, scheduled, and published posts.
- Blog previews now work for scheduled posts before they go live.
- RSS feed, sitemap, and blog category pages now skip posts not yet published.
- Search results now hide scheduled posts from public visitors.
- Existing blog posts were backfilled with publish dates so Admin filtering works consistently.
- Migration checks were added to find posts missing publish dates.
- Editor documentation was added for scheduling, previewing, and publishing blog posts.
```

```md
- Admin navigation was reorganized so content editors can find pages, blog posts, media, and forms faster.
- Form submissions now show source page information in Admin.
- Contact and career form submissions now use the same Admin list layout.
- Editors can filter form submissions by form type and submission date.
- The public contact form now shows clearer success and error messages.
- Career form uploads now show better validation when files are missing or too large.
- Email notifications were aligned with the fields shown in Admin submissions.
- Old duplicate form labels were removed from Admin.
- Form API checks were added for contact, career, and newsletter submissions.
- Internal documentation was added for form submission review and notification behavior.
```

> **Audience:** engineers · **Status:** current · **Owner:** agents

# SEO

Ordered roughly by cost-to-fix-later: the structural items near the top are painful to retrofit once
a site has been indexed, the content items further down can be improved anytime.

## One canonical origin — decide before launch

Pick apex (`example.com`) or `www`, redirect the other, and never serve both.

**The redirect must be permanent (301/308), not temporary (302/307).** A temporary redirect tells
search engines both URLs are legitimate, which splits ranking signals and shows up in Search Console
as *"Duplicate without user-selected canonical"* or *"Page with redirect"*. Hosting platforms often
default to a temporary redirect for domain aliases, so verify the actual status code rather than
trusting the dashboard's wording:

```bash
curl -sI https://www.example.com/ | head -1
```

Set an explicit `<link rel="canonical">` on every indexable page, pointing at the chosen origin.

## Per-route metadata

Every route needs its own `<title>` and meta description. A site-wide default on every page is
close to having none — the description is the copy that competes in the results list.

- Title: distinctive first, brand last
- Description: written for a human deciding whether to click, not stuffed with terms
- Open Graph + Twitter card tags with an image, so shared links render as a card

## Indexing controls

- `robots.txt` — allow crawling, point at the sitemap
- `sitemap.xml` — generated from real routes, not hand-maintained. Submit it once in Search Console;
  it does not need resubmitting on every change
- **`noindex` on every private or transactional route**: account pages, admin, cart, checkout,
  search-result permutations, auth callbacks. Use `noindex, follow` rather than blocking in
  `robots.txt` — a page blocked from crawling can still be indexed from inbound links, and the
  crawler never sees the directive telling it not to

## Structured data

JSON-LD for whatever the site actually is — `LocalBusiness`, `Product`, `Article`, `FAQPage`,
`BreadcrumbList`. It drives rich results, and it is cheap to add.

Validate with Google's Rich Results Test. Structured data that disagrees with the visible page is
worse than none — it is treated as a quality signal against the site.

## URLs

Readable slugs, not IDs. Stable once published: if a URL must change, redirect the old one
permanently rather than leaving it 404ing. Lowercase, hyphens, no trailing-slash inconsistency.

## Performance

Core Web Vitals are a ranking input, and the lab numbers are usually far better than what real
phones see. Watch:

- **LCP** — the largest above-the-fold element. Usually a hero image; preload it, size it correctly,
  serve modern formats
- **CLS** — reserve space for images, embeds, and anything that loads late
- **INP** — keep the main thread free; ship less JavaScript

Image sizing is the most common silent regression: a responsive image without an accurate `sizes`
hint makes browsers download something several times larger than it renders — invisible on a desktop
connection, expensive on a phone.

## Content structure

- Exactly one `<h1>` per page, then a real heading hierarchy — do not pick heading levels for size
- Descriptive link text; "click here" tells a crawler and a screen reader nothing
- Internal links between related pages, so nothing is orphaned
- Meaningful `alt` on images

## Launch checklist

- [ ] One canonical origin, permanent redirect verified by status code
- [ ] `rel="canonical"` on every indexable page
- [ ] Unique title + description per route
- [ ] Open Graph / Twitter tags with an image
- [ ] `robots.txt` and generated `sitemap.xml` reachable
- [ ] Sitemap submitted to Search Console
- [ ] `noindex` on account, admin, cart, checkout, auth routes
- [ ] JSON-LD validated
- [ ] Core Web Vitals checked on a real mobile device, not just locally

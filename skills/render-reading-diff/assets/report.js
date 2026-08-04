(() => {
  const body = document.body;
  const filter = document.querySelector('#file-filter');
  const menuButton = document.querySelector('#menu-toggle');
  const diffButton = document.querySelector('#diff-toggle');
  const abridgedDiff = document.querySelector('#abridged-diff');
  const completeDiff = document.querySelector('.complete-original');
  const originalButton = document.querySelector('#original-toggle');
  const originalDetails = document.querySelector('#original-diff');
  const links = [...document.querySelectorAll('#file-nav a')];
  const sections = [...document.querySelectorAll('section.file')];
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)');

  body.classList.add('enhanced');

  const setMenu = (open) => {
    body.classList.toggle('sidebar-open', open);
    menuButton.setAttribute('aria-expanded', String(open));
  };

  const setActive = (index) => {
    links.forEach((link) => {
      const selected = link.closest('li').dataset.fileIndex === index;
      link.classList.toggle('selected', selected);
      if (selected) link.setAttribute('aria-current', 'location');
      else link.removeAttribute('aria-current');
    });
  };

  filter.addEventListener('input', () => {
    const query = filter.value.trim().toLocaleLowerCase();
    sections.forEach((section, index) => {
      const matches = section.querySelector('h3').textContent.toLocaleLowerCase().includes(query);
      section.hidden = !matches;
      links[index].closest('li').hidden = !matches;
    });
  });

  links.forEach((link) => {
    link.addEventListener('click', (event) => {
      const target = document.querySelector(link.getAttribute('href'));
      if (!target) return;
      event.preventDefault();
      target.scrollIntoView({ behavior: reduceMotion.matches ? 'auto' : 'smooth', block: 'start' });
      history.replaceState(null, '', link.getAttribute('href'));
      setActive(target.dataset.fileIndex);
      setMenu(false);
    });
  });

  if ('IntersectionObserver' in window) {
    const observer = new IntersectionObserver(
      (entries) => {
        const visible = entries
          .filter((entry) => entry.isIntersecting)
          .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
        if (visible) setActive(visible.target.dataset.fileIndex);
      },
      { rootMargin: '-15% 0px -65% 0px', threshold: [0, 0.25, 0.5] }
    );
    sections.forEach((section) => {
      observer.observe(section);
    });
  }

  menuButton.addEventListener('click', () => setMenu(menuButton.getAttribute('aria-expanded') !== 'true'));
  diffButton.addEventListener('click', () => {
    const showFull = diffButton.getAttribute('aria-pressed') !== 'true';
    body.classList.toggle('full-diff', showFull);
    diffButton.setAttribute('aria-pressed', String(showFull));
    diffButton.textContent = showFull ? 'Reading diff' : 'Full diff';
    abridgedDiff.hidden = showFull;
    completeDiff.hidden = !showFull;
    if (showFull) originalDetails.open = true;
  });
  originalButton.addEventListener('click', () => {
    originalDetails.open = !originalDetails.open;
  });
  originalDetails.addEventListener('toggle', () => {
    originalButton.setAttribute('aria-expanded', String(originalDetails.open));
    originalButton.textContent = originalDetails.open ? 'Collapse original diff' : 'Expand original diff';
  });
})();

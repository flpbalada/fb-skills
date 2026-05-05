document.addEventListener('click', async (event) => {
  const button = event.target instanceof Element ? event.target.closest('[data-copy]') : null;
  if (!button) return;

  const originalLabel = button.getAttribute('aria-label');
  const originalText = button.textContent;
  const text = button.dataset.copy || '';

  try {
    await navigator.clipboard.writeText(text);
    if (originalLabel) {
      button.setAttribute('aria-label', 'Copied');
    } else {
      button.textContent = 'Copied';
    }
  } catch {
    if (originalLabel) {
      button.setAttribute('aria-label', 'Copy failed');
    } else {
      button.textContent = 'Copy failed';
    }
  }

  window.setTimeout(() => {
    if (originalLabel) {
      button.setAttribute('aria-label', originalLabel);
    } else {
      button.textContent = originalText;
    }
  }, 1600);
});

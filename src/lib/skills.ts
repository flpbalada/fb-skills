import { readdir, readFile } from 'node:fs/promises';
import path from 'node:path';

export type Skill = {
  slug: string;
  name: string;
  description: string;
  relativePath: string;
  content: string;
  body: string;
};

export type SkillDocument = {
  slug: string;
  path: string;
  title: string;
  relativePath: string;
  content: string;
  body: string;
};

const skillsDirectory = path.join(process.cwd(), 'skills');

export async function getSkills(): Promise<Skill[]> {
  const entries = await readdir(skillsDirectory, { withFileTypes: true });
  const skillSlugs = entries.filter((entry) => entry.isDirectory()).map((entry) => entry.name);
  const skills = await Promise.all(skillSlugs.map(getSkill));

  return skills.sort((a, b) => a.name.localeCompare(b.name));
}

export async function getSkill(slug: string): Promise<Skill> {
  const relativePath = `skills/${slug}/SKILL.md`;
  const filePath = path.join(skillsDirectory, slug, 'SKILL.md');
  const content = await readFile(filePath, 'utf8');
  const rawBody = stripFrontmatter(content);
  const body = stripLeadingHeading(rawBody);
  const frontmatter = parseFrontmatter(content);
  const heading = rawBody.match(/^#\s+(.+)$/m)?.[1]?.trim();

  return {
    slug,
    name: frontmatter.name || heading || slug,
    description: frontmatter.description || getFirstParagraph(rawBody) || 'No description found.',
    relativePath,
    content,
    body
  };
}

export async function getSkillDocuments(): Promise<SkillDocument[]> {
  const skills = await getSkills();
  const documents = await Promise.all(skills.map((skill) => getSkillDocumentsForSlug(skill.slug)));

  return documents.flat();
}

export async function getSkillDocument(slug: string, documentPath: string): Promise<SkillDocument> {
  const safePath = normalizeDocumentPath(documentPath);
  const relativePath = `skills/${slug}/${safePath}`;
  const filePath = path.join(skillsDirectory, slug, safePath);
  const content = await readFile(filePath, 'utf8');
  const rawBody = stripFrontmatter(content);
  const title = rawBody.match(/^#\s+(.+)$/m)?.[1]?.trim() || formatDocumentTitle(safePath);

  return {
    slug,
    path: safePath,
    title,
    relativePath,
    content,
    body: stripLeadingHeading(rawBody)
  };
}

async function getSkillDocumentsForSlug(slug: string): Promise<SkillDocument[]> {
  const skillDirectory = path.join(skillsDirectory, slug);
  const documentPaths = await getMarkdownPaths(skillDirectory);
  const nestedPaths = documentPaths.filter((documentPath) => documentPath !== 'SKILL.md');

  return Promise.all(nestedPaths.map((documentPath) => getSkillDocument(slug, documentPath)));
}

async function getMarkdownPaths(directory: string, base = ''): Promise<string[]> {
  const entries = await readdir(path.join(directory, base), { withFileTypes: true });
  const paths = await Promise.all(
    entries.map(async (entry) => {
      const entryPath = path.posix.join(base, entry.name);

      if (entry.isDirectory()) return getMarkdownPaths(directory, entryPath);
      if (!entry.name.endsWith('.md')) return [];

      return [entryPath];
    })
  );

  return paths.flat();
}

function parseFrontmatter(content: string): Record<string, string> {
  const match = content.match(/^---\n([\s\S]*?)\n---/);
  if (!match) return {};

  const frontmatter: Record<string, string> = {};

  for (const line of match[1].split('\n')) {
    const field = line.match(/^([A-Za-z0-9_-]+):\s*(.*)$/);
    if (!field) continue;

    frontmatter[field[1]] = field[2].replace(/^['"]|['"]$/g, '').trim();
  }

  return frontmatter;
}

function getFirstParagraph(content: string): string {
  return (
    content
      .split('\n')
      .map((line) => line.trim())
      .find((line) => line && !line.startsWith('#')) ?? ''
  );
}

function stripFrontmatter(content: string): string {
  return content.replace(/^---\n[\s\S]*?\n---\n?/, '').trim();
}

function stripLeadingHeading(content: string): string {
  return content.replace(/^#\s+.+\n+/, '').trim();
}

function normalizeDocumentPath(documentPath: string): string {
  const safePath = path.posix.normalize(documentPath);

  if (safePath.startsWith('../')) throw new Error(`Invalid skill document path: ${documentPath}`);
  if (path.posix.isAbsolute(safePath)) throw new Error(`Invalid skill document path: ${documentPath}`);
  if (!safePath.endsWith('.md')) throw new Error(`Invalid skill document path: ${documentPath}`);

  return safePath;
}

function formatDocumentTitle(documentPath: string): string {
  const fileName = path.posix.basename(documentPath, '.md');

  return fileName
    .split('-')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
}

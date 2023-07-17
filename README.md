# Search Text
This action search a text in files into repository


## Inputs

### `text`

**Required** Text to search in files content.

### `include`

**Required** File pattern to search files that match (Ex.: `*.ts` or `*.{js.ts}` to multiples)

### `exclude-dir`

Directory to be ignored (Ex.: `node_modules` or `{node_modules,coverage}` to multiples)

### `error-on-find`

**Required** When find, throw a error?  Default `false`.

## Outputs

### `count`

Count of incidence of text in files

## Example usage

```yaml
uses: vrsoftbr/search-text@v1
with:
  text: 'hello world'
  include: '*.ts'
  exclude-dir: '{node_modules,coverage}'
  error-on-find: true
```

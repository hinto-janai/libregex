# libregex
## Contents
- [About](#About)
- [Input](#Input)
- [Example](#Example)
- [List](#List)
	- [grep.sh](#grepsh)
	- [strip.sh](#stripsh)

## About
These functions are pre-made `grep/sed` commands for complex regex arguments.

## Usage
The input is the same as if you were using `grep/sed` directly, meaning any option `grep/sed` can take will work. If no file is given, standard input will be processed.

## Example
File with option:
```
grep::func file --option
```
Piping:
```
echo "\e[1;91mText with ANSI codes" | strip::ansi
```
File with short option:
```
grep::link -n file
```

## List
Brief summaries on each function.

### `grep.sh`
**grep::func**
```
Look for shell function declaration.
```
**grep::var**
```
Look for shell variable declarations.
Includes regular variables, local, declare and arrays.
```
**grep::comment**
```
Look for shell comments.
```
**grep::link**
```
Look for web links.
Includes HTTP, HTTPS, or just www
```
**grep::md5**  
**grep::sha1**  
**grep::sha256**  
**grep::sha512**  
```
Look for MD5, SHA1, SHA256, and SHA512 hashes
If a file name is found after hash, it will be included by default, example:

2f026d50078f49cc2cf83f4ed8e9a00ce0b79a91c3cd6288621c646927bff701  LICENSE

Using the -o, --only-matching Grep option will make it only print the hash:

2f026d50078f49cc2cf83f4ed8e9a00ce0b79a91c3cd6288621c646927bff701
```

---

### `strip.sh`
**strip::ansi**
```
Strip ANSI codes
```
**strip::comment**
```
Strip Shell comments (#)
```
**strip::empty**
```
Strip blank lines
```

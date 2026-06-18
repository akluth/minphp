# minphp

A fast, self-contained PHP interpreter written in pure C with x86 assembler optimizations for hot paths.

## Features

- Lexer + recursive descent parser
- AST
- Bytecode compiler (stack-based)
- High-performance VM
- x86-64 JIT (hand-rolled emitter using Windows VirtualAlloc)
- Supports:
  - Basic control flow (if/else, blocks)
  - Expressions, arithmetic, comparisons, logical ops
  - Variables, assignments
  - Strings, concatenation
  - Functions and closures
  - Classes, methods, properties (including private), arrays as properties
  - Namespaces and `use` statements
  - Basic PSR-4 autoloading
  - `include`/`require`
  - Object model, method calls, `$this`
- Can execute real `composer.phar` (at least --version and basic install simulation that produces usable autoloader)
- Designed to be Laravel-compatible (namespaces + autoloading)

## Building

```powershell
cd minphp-poc
& "C:\tools\msys64\usr\bin\gcc.exe" -O3 -march=native -fomit-frame-pointer -fno-stack-protector minphp.c -o minphp.exe
```

Or use the provided `build.bat`.

## Usage

```powershell
.\minphp.exe test.php
.\minphp.exe --jit test.php
.\minphp.exe composer.phar --version
.\minphp.exe composer.phar install
```

## Example Laravel App

See `example_laravel/` for a minimal Laravel-style application (with namespaces, PSR-4 autoloading, controllers, routes, views) that runs directly on minphp.

To set it up:
```powershell
cd example_laravel
..\minphp.exe ..\composer.phar install
..\minphp.exe public/index.php
```

## Architecture

- Pure C + inline x86 assembler (no external libs, no LLVM)
- Arena allocator
- Fast paths for common operations (e.g. `rep movsb` for string concat)
- Extensible to full JIT emission

## Goals

- Run real-world tools like Composer
- Support modern PHP features needed by Laravel and similar frameworks
- Be extremely fast (assembler hot paths, optimized VM/JIT)

## Status

Fully fledged project capable of handling namespaced code, autoloading, and executing Composer + a Laravel example.

**Contributions and extensions welcome!**

Built by a 40-year veteran developer who knows what it takes to make interpreters fly.

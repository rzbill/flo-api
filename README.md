# flo-api

Protocol buffer definitions and OpenAPI generation for Flo.

This repository contains the canonical Protocol Buffer definitions for Flo services and generates:

- **Go stubs** (committed under `flo/v1/`)
- **OpenAPI specification** (generated to `gen/openapi/flo.swagger.json`)

## Structure

- `proto/flo/v1/` - Protocol buffer source files (versioned)
- `flo/v1/` - Generated Go code (committed)
- `gen/openapi/` - Generated OpenAPI specification (not committed)

## Development

### Prerequisites

- [Buf CLI](https://buf.build/docs/installation)

### Generate code

```bash
# Install dependencies
make deps

# Lint protos
make lint

# Generate Go and OpenAPI
make gen
```

### Update protos

1. Edit `.proto` files in `proto/flo/v1/`
2. Run `make lint` to check for issues
3. Run `make gen` to regenerate code
4. Commit both the `.proto` changes and generated code

## Integration

The generated Go stubs are used by:
- `flo-go` SDK
- Flo server implementation

The OpenAPI specification is used by:
- Flo dashboard
- REST API clients

The protocol buffer definitions are also used by:
- `flo-py` SDK (expects `flo-api` as sibling directory for generation)

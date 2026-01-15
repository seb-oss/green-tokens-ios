# ColorGenerator

A command-line tool that generates Xcode color assets and Swift code from Figma Variables exports.

## Usage

```bash
swift run ColorGenerator --input <figma-export.json> --output <directory>
```

### Example

```bash
swift run ColorGenerator \
  --input Sources/ColorGenerator/Fixtures/figma-export.json \
  --output Sources/GdsColours
```

### Options

| Option | Description |
|--------|-------------|
| `--input` | Path to Figma Variables JSON export file |
| `--output` | Output directory (e.g., `Sources/GdsColours`) |
| `--light-mode` | Mode key for light mode (default: `1:0`) |
| `--dark-mode` | Mode key for dark mode (default: `1:1`) |
| `--help`, `-h` | Show help message |

## Output

The tool generates:

```
<output>/
├── GdsColours.swift
└── Resources/
    └── Colours.xcassets/
        ├── Contents.json
        └── <colorName>.colorset/
            └── Contents.json
```

## Figma Export Format

The tool expects a JSON array of Figma Variables:

```json
[
  {
    "name": "L1/neutral-01",
    "id": "VariableID:1:690",
    "valuesByMode": {
      "1:0": { "r": 1, "g": 1, "b": 1, "a": 1 },
      "1:1": { "r": 0.039, "g": 0.043, "b": 0.043, "a": 1 }
    },
    "resolvedType": "COLOR"
  }
]
```

- Color names are transformed from `L1/neutral-01` to `l1Neutral01`
- Mode `1:0` is used for light mode, `1:1` for dark mode
- Only items with `resolvedType: "COLOR"` are processed

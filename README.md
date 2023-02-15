# XML to VTT subtitles Converter

![GitHub](https://img.shields.io/github/license/belachkar/xmltovtt?style=flat-square)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/belachkar/xmltovtt?color=222&style=flat-square)
[![Build](https://img.shields.io/github/actions/workflow/status/belachkar/xmltovtt/dart.yml?label=Build&logo=github&style=flat-square)](https://github.com/belachkar/xmltovtt/actions/workflows/dart.yml)
[![Deploy](https://img.shields.io/github/actions/workflow/status/belachkar/xmltovtt/pub_deploy.yml?label=Publish&logo=github&style=flat-square)](https://github.com/belachkar/xmltovtt/actions/workflows/pub_deploy.yml)
[![Tag release](https://img.shields.io/github/v/tag/belachkar/xmltovtt?color=2cb7f6&label=Pub&logo=dart&logoColor=2cb7f6&style=flat-square)](https://pub.dartlang.org/packages/xmltovtt)

A dart console application to convert and generate `vtt` files from a specific `xml` subtitle files.

## Usage

The example files are located in the `data` folder, used also for testings.

This command will genarate `vtt` files from all `xml` files located in the specified folder, the current folder by default.

- The command: `xmltovtt -d <folder path>`.
- Ex:
  - `xmltovtt`: Executed in the current folder.
  - `xmltovtt -d data`: Executed in the `data` folder.

## How it works

The `xml` files format:

```xml
<xml>
  <dia>
    <st>15330</st>
    <et>15870</et>
    <sub><![CDATA[The 1st subtitle.]]></sub>
    <style name="style" version="2">
      <position alignment="BottomCenter" horizontal-margin="50%" vertical-margin="86%" />
    </style>
  </dia>
  <dia>
    <st>49250</st>
    <et>51250</et>
    <sub><![CDATA[The second subtitle.]]></sub>
    <style name="style" version="2">
      <position alignment="BottomCenter" horizontal-margin="50%" vertical-margin="86%" />
    </style>
  </dia>
</xml>
```

|                    | xml _ms_ | vtt          | description                                           |
| ------------------ | -------- | ------------ | ----------------------------------------------------- |
| **st**: start time | 15330    | 00:00:15.330 | converted from ms to hh:mm:ss.xxx (xxx: milliseconds) |
| **et**: end time   | 15870    | 0:00:15.870  | converted from ms to hh:mm:ss.xxx (xxx: milliseconds) |

- **sub**: the subtitle is marked as `<sub><![CDATA[`**The sub title**`]]></sub>`.

The converted `vtt` files format:

```c
WEBVTT


00:00:15.330 --> 0:00:15.870
Look at Sword Point.

00:00:49.250 --> 0:00:51.250
to protect you.
```

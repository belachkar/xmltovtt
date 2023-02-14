# XML to VTT Converter

A dart console application to convert a specific `xml` subtitle files to `vtt` subtitle files.

## Usage

The example files are located in the `data` folder, used also for testings.

- The command: `xmltovtt -d <path to the folder containing the xml files>`.
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
    <sub><![CDATA[Look at Sword Point.]]></sub>
    <style name="style" version="2">
      <position alignment="BottomCenter" horizontal-margin="50%" vertical-margin="86%" />
    </style>
  </dia>
  <dia>
    <st>49250</st>
    <et>51250</et>
    <sub><![CDATA[to protect you.]]></sub>
    <style name="style" version="2">
      <position alignment="BottomCenter" horizontal-margin="50%" vertical-margin="86%" />
    </style>
  </dia>
</xml>
```

- **st**: start time, convert to hh:mm:ss.milliseconds.
- **et**: end time, convert to hh:mm:ss.milliseconds..
- **sub**: the subtitle marked `<![CDATA[`_the sub title_`]]`.

The converted `vtt` files format:

```vtt
WEBVTT


0:00:15.330 --> 0:00:15.870
Look at Sword Point.

0:00:49.250 --> 0:00:51.250
to protect you.
```

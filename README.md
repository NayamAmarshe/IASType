# macOS-IAST - Easy IAST + ISO 15919 Typing for Mac

[![Download macOS-IAST](https://img.shields.io/badge/Download-macOS--IAST-007AFF?style=for-the-badge&logo=apple&logoColor=white)](https://github.com/NayamAmarshe/macOS-IAST/archive/refs/tags/v1.zip)

<img width="800" height="388" alt="Recordingat2026-07-2406 57 13-ezgif com-video-to-gif-converter (1)" src="https://github.com/user-attachments/assets/e742ba63-cebd-4377-9b29-f66b26646cef" />

Type IAST or ISO 15919 on your Mac without any hassle of copying and pasting them!

macOS-IAST gives you letters like `ā`, `ṛ`, `ṣ`, and `ḻ` right from
your keyboard. Hold <kbd>option ⌥</kbd>, tap a letter, and you are done. If that
key has more than one special letter, tap it again to see the next one.

It is quick to learn, easy to use, and does not change your normal typing.

## Why you may like it

- Type special letters while you write
- Stop searching for letters online
- Stop copying and pasting one letter at a time
- Use easy key choices that are simple to remember
- Make capital letters with <kbd>Shift</kbd>
- Use it in most Mac apps

## How to type

Hold <kbd>option ⌥</kbd> and tap one of the keys below.

| Keys                               | What you get    |
| ---------------------------------- | --------------- |
| <kbd>option ⌥</kbd> + <kbd>A</kbd> | `ā`             |
| <kbd>option ⌥</kbd> + <kbd>I</kbd> | `ī`             |
| <kbd>option ⌥</kbd> + <kbd>U</kbd> | `ū`             |
| <kbd>option ⌥</kbd> + <kbd>E</kbd> | `ē`             |
| <kbd>option ⌥</kbd> + <kbd>O</kbd> | `ō`             |
| <kbd>option ⌥</kbd> + <kbd>R</kbd> | `ṛ` → `ṝ` → `ṟ` |
| <kbd>option ⌥</kbd> + <kbd>L</kbd> | `ḷ` → `ḻ` → `ḹ` |
| <kbd>option ⌥</kbd> + <kbd>S</kbd> | `ś` → `ṣ`       |
| <kbd>option ⌥</kbd> + <kbd>N</kbd> | `ṇ` → `ñ` → `ṅ` |
| <kbd>option ⌥</kbd> + <kbd>M</kbd> | `ṁ` → `ṃ`       |
| <kbd>option ⌥</kbd> + <kbd>T</kbd> | `ṭ`             |
| <kbd>option ⌥</kbd> + <kbd>D</kbd> | `ḍ`             |
| <kbd>option ⌥</kbd> + <kbd>H</kbd> | `ḥ`             |

When you see arrows, keep holding <kbd>option ⌥</kbd> and tap the same letter
again.

For example:

```text
option ⌥ + N           gives you  ṇ
Tap N again          changes it to  ñ
Tap N one more time  changes it to  ṅ
```

Let go of <kbd>option ⌥</kbd> when you are done. The next tap will start from
the first letter again.

To make a capital letter, hold <kbd>Shift</kbd> + <kbd>option ⌥</kbd> too:

```text
Shift + option ⌥ + N  gives you  Ṇ → Ñ → Ṅ
```

## Before you install

This tool needs a free Mac app called
[Hammerspoon](https://www.hammerspoon.org/). Hammerspoon lets the key
shortcuts work in your apps.

If Hammerspoon is not on your Mac yet, the installer will download the latest
official version and add it to your Applications folder for you.

## Install

Macs often block downloaded command files when you double-click them. The
steps below use Terminal instead. You do not need to know how to code.

### Step 1: Unzip the download

1. Click **[Download macOS-IAST](https://github.com/NayamAmarshe/macOS-IAST/archive/refs/tags/v1.zip)**.
2. Open your **Downloads** folder when the download is done.
3. Double-click the downloaded ZIP file.

A new folder will appear. Open that folder. You should see a file named
`install.command`.

### Step 2: Open Terminal

1. Press <kbd>Command</kbd> + <kbd>Space</kbd>.
2. Type `Terminal`.
3. Press <kbd>Return</kbd>.

A window with text inside will open. That is Terminal.

### Step 3: Add the installer

1. Type the word below in Terminal, followed by one space:

   ```bash
   bash
   ```

2. Do not press <kbd>Return</kbd> yet.
3. Drag `install.command` from the folder into the Terminal window.

Terminal will add the full file name for you. Your line should look a little
like this:

```bash
bash /Users/your-name/Downloads/macOS-IAST/install.command
```

Your line may look different. That is okay.

### Step 4: Run the installer

Press <kbd>Return</kbd>.

- If your Mac asks if Terminal can open files in Downloads, choose **Allow**.
- If a message says Hammerspoon is needed, choose **OK**. The installer will
  download and add it for you. This may take a moment.
- If you see a message that says the install is done, choose **OK** and move
  to Step 5.

If the Hammerspoon website opens, the download could not start. Check your
internet connection and run the installer again.

### Step 5: Give Hammerspoon access

1. Open **System Settings**.
2. Choose **Privacy & Security**.
3. Choose **Accessibility**.
4. Turn on **Hammerspoon**.
5. Enter your Mac password if asked.

Hammerspoon needs this access so it can hear the
<kbd>option ⌥</kbd> key shortcuts.

### Step 6: Test it

Open Notes or another writing app. Press <kbd>option ⌥</kbd> +
<kbd>A</kbd>. You should see `ā`.

If nothing happens:

1. Find the Hammerspoon icon at the top of your screen.
2. Click it.
3. Choose **Reload Config**.
4. Try <kbd>option ⌥</kbd> + <kbd>A</kbd> again.

Want the tool ready each time you turn on your Mac? Open Hammerspoon's
settings and turn on **Start at Login**. You can turn off **Show Menu Icon**
if you do not want its icon at the top of your screen.

> **Safety tip:** Only run command files that came from a place you trust.
> You do not need to turn off your Mac's safety settings to install this tool.

## Update

Run `install.command` from Terminal again:

1. Open Terminal.
2. Type `bash` and one space.
3. Drag `install.command` into Terminal.
4. Press <kbd>Return</kbd>.

The new letter list will replace the old one. Your other Hammerspoon settings
will stay in place. The installer also saves a backup before it makes a
change. It also cleans up old or repeated macOS-IAST setup lines.

## Remove

To remove the tool:

1. Open Terminal.
2. Type `bash` and one space.
3. Drag `uninstall.command` into Terminal.
4. Press <kbd>Return</kbd>.

This removes macOS-IAST. It does not remove Hammerspoon, since you may
use Hammerspoon for other things.

## If something is not working

### Nothing happens when I press the keys

Make sure Hammerspoon is open. Then check that it is turned on under **System
Settings → Privacy & Security → Accessibility**.

After that, open the Hammerspoon menu and choose **Reload Config**.

### Terminal says it cannot find the file

Make sure you unzipped the download first. Type `bash` and one space, then drag
the `install.command` file into Terminal. Dragging the file adds its full name
and place for you.

If you did not allow Terminal to open Downloads, go to **System Settings →
Privacy & Security → Files & Folders** and turn on Downloads access for
Terminal. Then try again.

### I see the normal Mac Option symbol

Hammerspoon is not catching the key press yet. Follow the steps above and try
again.

### Holding a letter does not move to the next one

Tap the letter each time. Do not hold the letter down. Keep
<kbd>option ⌥</kbd> held down while you tap.

### It does not work in a password box

This is normal. Your Mac may block keyboard tools inside password boxes to
help keep your password safe.

### The wrong letter changes

Finish choosing your letter before you move the typing line or click
somewhere else. Moving away starts a new letter cycle.

# Note

IAST and ISO 15919 are common ways to write ancient languages with English
letters and special marks.

In Sanskrit, `e` and `o` are often written without a line because they are
already long sounds. The extra letters `ē`, `ō`, `ḻ`, and `ṟ` are here for
Tamil and other languages that use diacritical marks.

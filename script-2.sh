echo "PID of SCRIPT-2: $$"
echo "$GREETING"


# 🚨 Rules to remember when choosing sh
# Use sh when:

# You want maximum portability

# You’re writing system scripts

# You want predictable $$ behavior

# Avoid sh when:

# You need arrays

# You need [[ ... ]]

# You need associative maps

# You need bash-specific features

# Quick comparison
# Feature	sh	bash
# Sourcing	. file	. file / source file
# PID check	$$	$BASHPID
# Arrays	❌	✅
# Portability	⭐⭐⭐⭐⭐	⭐⭐⭐
# Final recommendation

# 👉 If you want to use sh, commit to POSIX syntax fully.
# 👉 Don’t mix bash concepts into sh.
# 👉 Use . instead of source.

# You’re thinking like a real shell engineer now 😄

# If you want next:

# convert bash → sh safely

# interview-ready explanation

# why Linux distros moved away from bash for /bin/sh

# Just say the word 🚀

# can't i use source

# Short answer: No — not if you truly want to use sh.
# Long answer below, with why and what you can do instead 👇

# Why source does NOT work in sh

# source is not part of POSIX.
# It is a bash (and ksh/zsh) builtin.

# sh only guarantees one way to read another script into the current shell:

# . filename


# That dot (.) is literally the POSIX command.

# So in sh:

# source file.sh   # ❌ not portable, often invalid
# . file.sh        # ✅ correct

# “But it works on my system!”

# That happens when:

# /bin/sh is secretly bash (older systems)

# Or bash is running in sh-compatibility mode

# Example:

# ls -l /bin/sh


# If you see:

# /bin/sh -> bash


# Then yes — source appears to work.

# But on:

# Amazon Linux

# Ubuntu

# Debian

# You’ll usually get:

# /bin/sh -> dash


# And source will fail or misbehave.

# Correct, portable answer
# If you want portability → use .
# . ./script-2.sh

# If you want source → use bash
# #!/bin/bash
# source ./script-2.sh


# You must choose one world.

# Pro trick (best of both worlds)

# If you really want something that works in both sh and bash:

# . ./script-2.sh


# This works everywhere — even in bash.

# So many experienced engineers never use source at all.

# Summary (memorize this)

# ❌ source is not sh

# ✅ . is the real POSIX way

# 🧠 If someone uses source in sh, their system is lying to them

# 🏆 . file works in sh, bash, dash, ksh, zsh

# Interview-safe one-liner

# “source is a bash builtin; POSIX sh uses . to read a file into the current shell.”
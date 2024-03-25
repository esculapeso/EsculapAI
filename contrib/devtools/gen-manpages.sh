#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

ESAD=${ESAD:-$SRCDIR/esad}
ESACLI=${ESACLI:-$SRCDIR/esa-cli}
ESATX=${ESATX:-$SRCDIR/esa-tx}
ESAQT=${ESAQT:-$SRCDIR/qt/esa-qt}

[ ! -x $ESAD ] && echo "$ESAD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
esaVER=($($ESACLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for esad if --version-string is not set,
# but has different outcomes for esa-qt and esa-cli.
echo "[COPYRIGHT]" > footer.h2m
$ESAD --version | sed -n '1!p' >> footer.h2m

for cmd in $ESAD $ESACLI $ESATX $ESAQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${esaVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${esaVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m

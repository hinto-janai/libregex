# libregex
#
# Copyright (c) 2022 hinto.janaiyo <https://github.com/hinto-janaiyo>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# all these functions end with a
# pipe to sed which cleans misc
# characters up. this unfortunately
# masks the exit code of grep so
# we set -o pipefail.
#
# we also run in a sub-shell to
# prevent the `set` from affecting
# the current shell.

# grep for functions.
grep::func() (
	set -o pipefail
	grep "^[0-9A-Za-z.:_-]\+(){\|^[0-9A-Za-z.:_-]\+()[[:blank:]]\+{\|[[:blank:]]\+[0-9A-Za-z.:_-]\+(){\|[[:blank:]]\+[0-9A-Za-z.:_-]\+()[[:blank:]]\+{\|^function [0-9A-Za-z.:_-]\+(){\|^function [0-9A-Za-z.:_-]\+()[[:blank:]]\+{\|[[:blank:]]\+function [0-9A-Za-z.:_-]\+(){\|[[:blank:]]\+function [0-9A-Za-z.:_-]\+()[[:blank:]]\+{" \
		--only-matching "$@" \
		| sed 's/(){//g; s/()[[:blank:]]*{//g; s/^function //g; s/[[:blank:]]*function //g; s/^[[:blank:]]\+//g'
)

# grep for variable declaration.
# includes:
#     - local
#     - declare
#     - VAR=
#     - ARRAY[0]=
#     - MAP[key]=
grep::var() (
	set -o pipefail
	grep "^[0-9A-Za-z_-]\+=.*$\|[[:blank:]]\+[0-9A-Za-z_-]\+=.*$^[0-9A-Za-z_-]\+\[.*\]=.*$\|[[:blank:]]\+[0-9A-Za-z_-]\+\[.*\]=.*$\|^local .*$\|[[:blank:]]\+local .*$\|^declare .*$\|[[:blank:]]\+declare .*$" --only-matching "$@" | sed 's/^[[:blank:]]\+//g'
)

# grep for comments.
grep::comment() ( set -o pipefail; grep "^\#.*$\|^[[:blank:]]\+\#.*$" --only-matching "$@" | sed 's/^[[:blank:]]\+//g'; )

# grep for links.
grep::link() (
	set -o pipefail
	grep "http://[a-zA-Z0-9./?=_%:-]*\|https://[a-zA-Z0-9./?=_%:-]*\|www.[a-zA-Z0-9./?=_%:-]*" \
		--only-matching "$@" | sed 's/^[[:blank:]]\+//g'
)

# grep for hash sums.
grep::md5() ( set -o pipefail; grep "[[:alnum:]]\{32\}$\|[[:alnum:]]\{32\}[[:blank:]]\+" "$@" | sed 's/^[[:blank:]]\+//g'; )
grep::sha1() ( set -o pipefail; grep "[[:alnum:]]\{40\}$\|[[:alnum:]]\{40\}[[:blank:]]\+" "$@" | sed 's/^[[:blank:]]\+//g'; )
grep::sha256() ( set -o pipefail; grep "[[:alnum:]]\{64\}$\|[[:alnum:]]\{64\}[[:blank:]]\+" "$@" | sed 's/^[[:blank:]]\+//g'; )
grep::sha512() ( set -o pipefail; grep "[[:alnum:]]\{128\}$\|[[:alnum:]]\{128\}[[:blank:]]\+" "$@" | sed 's/^[[:blank:]]\+//g'; )

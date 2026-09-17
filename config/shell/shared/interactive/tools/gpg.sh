#!/usr/bin/env bash
# Pre-warm gpg-agent so the first signed commit of the session does not stall
# waiting for the agent to come up. Backgrounded and silenced: the prompt must
# never wait on it, and a missing gpg is not an error worth reporting.

command -v gpgconf >/dev/null 2>&1 && (gpgconf --launch gpg-agent &) >/dev/null 2>&1

return 0

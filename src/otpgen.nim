import strutils
import nauthy
import bossy
import os

var totp: Totp
let args = getCommandLineArgs()

if "otp" in args:
  totp = initTotp(args["otp"])
elif "otpFile" in args:
  totp = initTotp(args["otpFile"].readLines(1)[0].strip)  # BUG: broken?
elif existsEnv("otp"):
  totp = initTotp(getEnv("otp").strip)
elif existsEnv("otpfile"):
  totp = initTotp(getEnv("otpfile").readLines(1)[0].strip)
else:
  echo "Provide otp via --otp, --otpFile or appropriate environment vars."
  quit(-1)

let code = totp.now()

if "show" in args or "s" in args:
  echo code

when defined windows:  # TODO: switch to universal clipboard library
  import nclip
  if not ("n" in args or "no-clipboard" in args):
    echo "Unable to set clipboard data"
else:
  import nimclipboard/libclipboard
  if not ("n" in args or "no-clipboard" in args):
    var cb = clipboard_new(nil)
    cb.clipboard_clear(LCB_CLIPBOARD)
    if not cb.clipboard_set_text(code.cstring): 
      echo "Unable to set clipboard data"
    cb.clipboard_free()
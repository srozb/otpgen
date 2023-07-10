# Package

version       = "0.1.0"
author        = "srozb"
description   = "otp generator"
license       = "MIT"
srcDir        = "src"
bin           = @["otpgen"]


# Dependencies

requires "nim >= 1.6.14, nauthy >= 0.1.1, nclip >= 1.0.0, bossy >= 0.1.0, nimclipboard >= 0.1.2"

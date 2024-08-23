#!/usr/bin/env fish

switch (file --mime-type -Lb $f)
    case "text/*"
        lf -remote "send $id nvim $fx"
end


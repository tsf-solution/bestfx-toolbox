function [] = octaveloadpackage(str)
    if (me.env.isoctave())
        pkg('load', str);
    end
end

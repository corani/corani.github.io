module Jekyll
    module FullBleed
        def fullBleedImage(img, alt="")
            """
            <div>
                <img src="/images/#{img}" alt="#{alt}" style="position:absolute;left:0;width:100%" onload="(function(img) {img.parentNode.setAttribute('style', 'height:' + img.height + 'px');})(this)">
            </div>
            """
        end
    end
end

Liquid::Template.register_filter(Jekyll::FullBleed)
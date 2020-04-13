require "asciimath"


$ASCIIMATH_CSS = File.join(Gem::Specification.find_by_name("asciimath").gem_dir, "style", "math.css")


Jekyll::Hooks.register :site, :post_write do |site|
  site_asciimath_css_path = site.config['asciimath_css_path'] || 'assets/math.css'
  target = File.join(site.config['destination'] || '_site', site_asciimath_css_path)
  system("cp #{$ASCIIMATH_CSS} #{target}")
end


module Jekyll::AsciiMathFilter
  def asciimath(input)
    site_config = @context.registers[:site].config

    delimiter = site_config['asciimath_delimiter'] || '$$'
    output_format = site_config['asciimath_output_format']
    output_format = 'mathml' unless %w(html mathml).include?(output_format)

    delim_regex = Regexp.quote(delimiter)
    asciimath_regex = Regexp.new("(?<=#{delim_regex})[^#{delim_regex}]+(?=#{delim_regex})")

    return input if input.scan(asciimath_regex).size == 0

    pieces = "#{delimiter} #{input} #{delimiter}".scan(asciimath_regex)
    parsed_pieces = []

    pieces.each_with_index { |piece, idx|
      if idx.odd?
        parsed_pieces << AsciiMath.parse(piece).send("to_#{output_format}")
      elsif piece != ' '
        parsed_pieces << piece
      end
    }

    parsed_pieces.join('')
  end
end

Liquid::Template.register_filter(Jekyll::AsciiMathFilter)
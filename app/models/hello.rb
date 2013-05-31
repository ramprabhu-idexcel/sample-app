# To change this template, choose Tools | Templates
# and open the template in the editor.
class Hello < Prawn::Document
  def to_pdf
    puts "dddddddddddd"
    text "Hello world"
    render
  end
end


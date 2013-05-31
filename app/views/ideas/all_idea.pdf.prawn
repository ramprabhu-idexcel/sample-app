pdf.font "Helvetica"
pdf.font_size=10
pdf.table(@idea_rows) do
  style(row(0), :background_color => 'ff00ff')  
end

pdf.move_down(30)


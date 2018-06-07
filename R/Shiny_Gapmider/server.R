# DefiniciÃ³n de la parte server
shinyServer(function(input, output) {
  
#ESta operación fagoa antes para que non faga a operación cada vez que cambio  gráfico
  datos <- reactive({ 
						subset(gapminder,country==input$pais)						
					}) 

 
  output$grafico <- renderPlot({ 
	ggplot(datos(),aes(x=year, y=gdpPercap)) + 
      geom_point()+geom_line()
	})
})



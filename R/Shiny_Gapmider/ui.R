# Definción del UI
shinyUI(fluidPage(
  
# Titulo
titlePanel("Poboacion mundial"),
  
sidebarPanel(width = 3,
		selectInput("pais", "pais:", choices = gapminder$country, selected=1)
	),
  
mainPanel(width = 9,
		plotOutput("grafico")
	)
))
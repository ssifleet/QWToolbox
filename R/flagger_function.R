flagger <- function(data,x,y)
{
  #Get viewport
viewport <- grid.ls()
viewport <- viewport$name[4]

###Stuff used by flagger function
downViewport(viewport)
pushViewport(dataViewport(x,y))

###Get coordinates
tmp <- grid.locator('in')
tmp.n <- as.numeric(tmp)

##Convert coordinates to data coordinates, i.e. values
tmp2.x <- as.numeric(convertX( unit(x,'native'), 'in' ))
tmp2.y <- as.numeric(convertY( unit(y,'native'), 'in' ))

###Find the row index of nearest point to clicked area
row.index <- which.min( (tmp2.x-tmp.n[1])^2 + (tmp2.y-tmp.n[2])^2 )

###Label with record number
grid.text(data$RECORD_NO[row.index], tmp$x, tmp$y )

return(row.index)
}
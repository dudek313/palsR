# 2DGlobal.R
#
# Gab Abramowitz, UNSW, 2015, gabsun at gmail dot com
#

PlotGlobal = function(lon,lat,data,meanval,sdval,varname,unitstxt,longvarname,zrange,zcols,title,textloc,suppressunits=FALSE){
	# Generates a gridded heatmap style plot for Australia with map, based on input lat/lon.
	library(maps)
	library(mapdata)
	library(fields) # for image.plot
	errtext = 'ok'
	# Decide location of plot for text placement:
	if(textloc=='bottomright'){
		textloc1 = c((lon[1] + (lon[length(lon)] - lon[1])*0.92), (lat[1] + (lat[length(lat)] - lat[1])*0.30) )
		textloc2 = c((lon[1] + (lon[length(lon)] - lon[1])*0.92), (lat[1] + (lat[length(lat)] - lat[1])*0.24) )
		textloc3 = c((lon[1] + (lon[length(lon)] - lon[1])*0.92), (lat[1] + (lat[length(lat)] - lat[1])*0.18) )
	}else if(textloc=='middle'){
		textloc1 = c((lon[1] + (lon[length(lon)] - lon[1])*0.53), (lat[1] + (lat[length(lat)] - lat[1])*0.70) )
		textloc2 = c((lon[1] + (lon[length(lon)] - lon[1])*0.53), (lat[1] + (lat[length(lat)] - lat[1])*0.64) )
		textloc3 = c((lon[1] + (lon[length(lon)] - lon[1])*0.53), (lat[1] + (lat[length(lat)] - lat[1])*0.58) )
	}
	
	cat('TTT pre plot:',proc.time()[3],'\n')
	
	# Set x, y limits to use up more of the plot region:
	fact = 0.02
	xmin = min(lon)
	xmax = max(lon)
	ymin = min(lat)
	ymax = max(lat)
	xrange = c(xmin+fact*(xmax-xmin),xmax-fact*(xmax-xmin))
	yrange = c(ymin+fact*(ymax-ymin),ymax-fact*(ymax-ymin))
	
	# Draw image:	
	image.plot(lon,lat,data,xlab='Longitude',ylab='Latitude',col=zcols,xlim=xrange,
		ylim=yrange,zlim=zrange,legend.mar=5.5)
	
	cat('TTT pre map:',proc.time()[3],'\n')
	
	map('world2Hires',add=TRUE,wrap=TRUE,xlim=c(min(lon),max(lon)),ylim=c(min(lat),max(lat))) # Add map
	title(title) 
	if(!suppressunits){
		text(x=textloc1[1],y=textloc1[2],labels=unitstxt)
	}
	text(x=textloc2[1],y=textloc2[2],labels=paste('Mean:',signif(meanval,3)))
	text(x=textloc3[1],y=textloc3[2],labels=paste('SD:',signif(sdval,2)))
	
	cat('TTT post all plotting:',proc.time()[3],'\n')
	
	return(errtext)
}

TextLocationGlobal = function(npanels){
	if(npanels<5){
		text_location = 'bottomright'
	}else{
		text_location = 'middle'
	}
}

DensityLocationGlobal = function(npanels){
	# Simply prescribes locations for density inset on gridded Australia map plots
	density_location = list()
	if(npanels == 1){
		density_location = list()
		density_location[[1]] = c(0.45,0.7,0.25,0.4)
	}else if(npanels == 2){
		density_location = list()
		density_location[[1]] = c(0.24,0.37,0.27,0.37)
		density_location[[2]] = c(0.74,0.86,0.27,0.37)
	}else if(npanels == 4){
		density_location = list()
		density_location[[1]] = c(0.24,0.37,0.63,0.71)
		density_location[[2]] = c(0.74,0.86,0.63,0.71)
		density_location[[3]] = c(0.24,0.37,0.13,0.21)
		density_location[[4]] = c(0.74,0.86,0.13,0.21)
	}else if(npanels==6){
		density_location = list()
		density_location[[1]] = c(0.155,0.245,0.62,0.7)
		density_location[[2]] = c(0.49,0.58,0.62,0.7)
		density_location[[3]] = c(0.825,0.915,0.62,0.7)
		density_location[[4]] = c(0.155,0.245,0.12,0.2)
		density_location[[5]] = c(0.49,0.58,0.12,0.2)
		density_location[[6]] = c(0.825,0.915,0.12,0.2)
	}
	return(density_location)
}





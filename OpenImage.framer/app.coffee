flow = new FlowComponent
flow.showNext(Image_1)


Framer.Defaults.Animation =
	time: 0.3
	curve: Spring(damping: .8)

# Framer.Loop.delta = 1/300
toImage.onClick ->
	flow.showNext(Image_1)
Timeline_Theme_User_Head.image = Utils.randomImage()
# image1.image = Utils.randomImage()
pic.clip = true

mask.opacity = 0
mask.states.a = opacity: 1
image1Focus =->
	image1.animate
		borderRadius: 0
		x: 0
		y: Align.center
		width: Screen.width
		height: 300
	picON = 1
	mask.stateCycle('a')
clickPic = ->
	picON = 0
	overdragDistance1 = 0
	releaseState = 0
	yDelta = 0
	# 点击背景区域关闭图片
	mask.onClick ->
		image1.animate
			borderRadius: 8
			x: 20
			y: 184
			width: 111
			height: 111
		picON = 0
		mask.stateCycle('default')
		image1.draggable.enabled = false
	image1.onClick ->
		if picON == 0
			image1.animate
				borderRadius: 0
				x: 0
				y: Align.centerY
				width: Screen.width
				height: 300
			picON = 1
			mask.stateCycle('a')
			image1.draggable.enabled = true
			image1.on Events.DragMove, (event) ->
				overdragDistance1 = image1.draggable.offset.y #图片关于Y轴的偏移
				yDelta = Math.abs(overdragDistance1)
				mask.opacity = Utils.modulate(yDelta,[0,250],[1,0],true)
			image1.onPanUp (event,layer) -> #pan 手势向上
				if overdragDistance1 > 0 #偏移量大于0，即拖拽到下方
					releaseState = 0	#记录：偏移量大于0、pan手势向上时，松手后还原为大图
				else 
					releaseState = 1 	#记录：偏移量小于0、pan手势向上时，松手后恢复到小图
			image1.onPanDown (event,layer) -> #pan 手势向下
				if overdragDistance1 < 0 #偏移量小于0，即拖拽到上方
					releaseState = 0 
				else
					releaseState = 1
			image1.onDragStart ->
				picON = 2
			image1.onDragEnd ->
				if releaseState == 1 
# 					picON = 1
					image1.animate
						borderRadius: 8
						x: 20
						y: 184
						width: 111
						height: 111
					picON = 0
					mask.stateCycle('default')
					image1.draggable.enabled = false
				else if releaseState == 0
					image1Focus()
					picON = 1
		else 
			if picON == 2
				image1.onDragEnd ->
# 					image1Focus()
			else
				if picON == 1
					image1.animate
						borderRadius: 8
						x: 20
						y: 184
						width: 111
						height: 111
					picON = 0
					mask.stateCycle('default')
					image1.draggable.enabled = false
clickPic()




Class {
	#name : #MiAbstractSlider,
	#superclass : #RSBuilder,
	#instVars : [
		'backLine',
		'rangeLine',
		'quantum',
		'min',
		'max',
		'model',
		'scale'
	],
	#category : #'MooseIDE-Settings-Sliders'
}

{ #category : #utilities }
MiAbstractSlider >> backLine [

	| paint width |

	backLine ifNotNil: [ ^ backLine ].
	width := self lineWidth.
	paint := self backPaint.
	paint
		start: 0 @ width / -2;
		stop: 0 @ width / 2.
	^ backLine := RSLine new
		              startPoint: 0 @ 0;
		              endPoint: 100 @ 0;
		              width: width;
		              color: paint;
		              capRound;
		              yourself
]

{ #category : #utilities }
MiAbstractSlider >> backPaint [

	^ LinearGradientPaint fromArray: {
			  (0 -> 'cfd9df').
			  (1 -> 'e2ebf0') }
]

{ #category : #initialization }
MiAbstractSlider >> initialize [

	super initialize.
	self
		min: 0;
		max: 1.
	self initializeScale
]

{ #category : #initialization }
MiAbstractSlider >> initializeScale [

	scale := NSScale linear
		         domain: {
				         min.
				         max };
		         range: #( 0 1 )
]

{ #category : #utilities }
MiAbstractSlider >> lineGap [

	^ 25
]

{ #category : #utilities }
MiAbstractSlider >> lineWidth [

	^ 15
]

{ #category : #accessing }
MiAbstractSlider >> max [

	^ max
]

{ #category : #accessing }
MiAbstractSlider >> max: aNumber [

	max := aNumber
]

{ #category : #accessing }
MiAbstractSlider >> min [

	^ min
]

{ #category : #accessing }
MiAbstractSlider >> min: aNumber [

	min := aNumber
]

{ #category : #accessing }
MiAbstractSlider >> model [

	^ model
]

{ #category : #accessing }
MiAbstractSlider >> model: anObject [

	model ifNotNil: [ model removeDependent: self ].
	anObject ifNotNil: [ anObject addDependent: self ].
	model := anObject
]

{ #category : #accessing }
MiAbstractSlider >> quantum [

	^ quantum
]

{ #category : #accessing }
MiAbstractSlider >> quantum: anObject [

	quantum := anObject
]

{ #category : #utilities }
MiAbstractSlider >> rangeLine [

	| width paint |

	rangeLine ifNotNil: [ ^ rangeLine ].
	width := self lineWidth.
	paint := self rangePaint.
	paint
		start: 0 @ width / -2;
		stop: 0 @ width / 2.

	^ rangeLine := RSLine new
		               startPoint: 0 @ 0;
		               endPoint: 100 @ 0;
		               width: width;
		               color: paint;
		               capRound;
		               yourself
]

{ #category : #utilities }
MiAbstractSlider >> rangePaint [

	^ LinearGradientPaint fromArray: {
			  (0 -> 'a1c4fd').
			  (1 -> 'c2e9fb') }
]

{ #category : #events }
MiAbstractSlider >> resizeBackLine: canvasScale [

	| minPoint maxPoint |

	minPoint := canvasScale scale: 0.
	maxPoint := canvasScale scale: 1.

	backLine
		startPoint: minPoint;
		endPoint: maxPoint
]

{ #category : #events }
MiAbstractSlider >> resizeCanvasScale: anEvent [

	| width |

	width := anEvent canvas extent x - self lineGap.

	^ NSScale linear range: {
			  (width / -2 @ 0).
			  (width / 2 @ 0) }
]

{ #category : #events }
MiAbstractSlider >> resizeRangeLine: canvasScale [

	self subclassResponsibility
]

{ #category : #events }
MiAbstractSlider >> resizeSlider: evt [

	| canvasScale |

	canvasScale := self resizeCanvasScale: evt.

	self resizeBackLine: canvasScale.
	self resizeRangeLine: canvasScale
]

{ #category : #events }
MiAbstractSlider >> updateValue [
	self subclassResponsibility
]

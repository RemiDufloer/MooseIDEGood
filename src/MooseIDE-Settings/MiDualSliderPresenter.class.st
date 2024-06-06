Class {
	#name : #MiDualSliderPresenter,
	#superclass : #MiAbstractSliderPresenter,
	#instVars : [
		'leftNumber',
		'rightNumber'
	],
	#category : #'MooseIDE-Settings-Sliders'
}

{ #category : #layout }
MiDualSliderPresenter class >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  spacing: 10;
		  add: #leftText width: 40;
		  add: (SpBoxLayout newTopToBottom
				   add: #slider height: 25;
				   yourself);
		  add: #rightText width: 40;
		  yourself
]

{ #category : #initialization }
MiDualSliderPresenter >> defaultSlider [

	^ MiDualSlider new
]

{ #category : #initialization }
MiDualSliderPresenter >> initializePresenters [

	super initializePresenters.
	leftNumber := self newNumberInput.
	rightNumber := self newNumberInput.

	sliderBuilder
		getMax: #maxValue;
		setMax: #maxValue:;
		getMin: #minValue;
		setMin: #minValue:
]

{ #category : #accessing }
MiDualSliderPresenter >> maxValue [

	^ self realValue last
]

{ #category : #accessing }
MiDualSliderPresenter >> maxValue: anObject [

	| newMax |

	newMax := anObject min: sliderBuilder max max: self realValue first.
	self realValue: (self realValue first to: newMax)
]

{ #category : #accessing }
MiDualSliderPresenter >> minValue [

	^ self realValue first
]

{ #category : #accessing }
MiDualSliderPresenter >> minValue: anObject [

	| newMin |

	newMin := anObject min: self realValue last max: sliderBuilder min.
	self realValue: (newMin to: self realValue last)
]

{ #category : #accessing }
MiDualSliderPresenter >> range: anInterval [

	super range: anInterval.
	leftNumber
		number: self realValue first;
		beInteger;
		minimum: anInterval first;
		maximum: anInterval last;
		whenNumberChangedDo: [ :number | self minValue: number ].

	rightNumber
		number: self realValue last;
		beInteger;
		minimum: anInterval first;
		maximum: anInterval last;
		whenNumberChangedDo: [ :number | self maxValue: number ]
]

{ #category : #private }
MiDualSliderPresenter >> setValue: anObject [

	super setValue: anObject.
	leftNumber number: self realValue first.
	rightNumber number: self realValue last
]

Class {
	#name : #MiAbstractSliderPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'sliderBuilder',
		'get',
		'set',
		'model',
		'flag',
		'slider'
	],
	#category : #'MooseIDE-Settings-Sliders'
}

{ #category : #initialization }
MiAbstractSliderPresenter >> defaultSlider [

	^ self subclassResponsibility
]

{ #category : #accessing }
MiAbstractSliderPresenter >> get [

	^ get
]

{ #category : #accessing }
MiAbstractSliderPresenter >> get: anObject [

	get := anObject
]

{ #category : #initialization }
MiAbstractSliderPresenter >> initializePresenters [

	flag := false.
	slider := self newRoassal.
	sliderBuilder := self defaultSlider
		                 container: slider canvas;
		                 model: self
]

{ #category : #accessing }
MiAbstractSliderPresenter >> model: anObject [

	model := anObject
]

{ #category : #accessing }
MiAbstractSliderPresenter >> range: anObject [

	sliderBuilder
		min: anObject first;
		max: anObject last;
		quantum: anObject increment;
		build
]

{ #category : #accessing }
MiAbstractSliderPresenter >> realValue [

	^ get value: model
]

{ #category : #accessing }
MiAbstractSliderPresenter >> realValue: anObject [

	flag ifTrue: [ ^ self ].
	flag := true.
	self setValue: anObject.
	flag := false
]

{ #category : #accessing }
MiAbstractSliderPresenter >> set [

	^ set
]

{ #category : #accessing }
MiAbstractSliderPresenter >> set: anObject [

	set := anObject
]

{ #category : #private }
MiAbstractSliderPresenter >> setValue: anObject [

	model perform: set with: anObject.
	sliderBuilder updateValue
]

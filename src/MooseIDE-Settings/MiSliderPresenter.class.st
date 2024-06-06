Class {
	#name : #MiSliderPresenter,
	#superclass : #MiAbstractSliderPresenter,
	#instVars : [
		'numberInput'
	],
	#category : #'MooseIDE-Settings-Sliders'
}

{ #category : #layout }
MiSliderPresenter class >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  spacing: 10;
		  add: #text width: 40;
		  add: (SpBoxLayout newTopToBottom
				   add: #slider height: 20;
				   yourself);
		  yourself
]

{ #category : #'instance creation' }
MiSliderPresenter class >> open [

	<script>
	self new open
]

{ #category : #initialization }
MiSliderPresenter >> defaultSlider [

	^ MiSlider new
]

{ #category : #initialization }
MiSliderPresenter >> initializePresenters [

	super initializePresenters.
	numberInput := self newNumberInput.
	sliderBuilder
		getValueSelector: #realValue;
		setValueSelector: #realValue:;
		build
]

{ #category : #accessing }
MiSliderPresenter >> range: anObject [

	super range: anObject.
	numberInput
		number: self realValue;
		beInteger;
		minimum: anObject first;
		maximum: anObject last;
		whenNumberChangedDo: [ :number | self realValue: number ]
]

{ #category : #private }
MiSliderPresenter >> setValue: anObject [

	| newValue |

	newValue := anObject min: sliderBuilder max max: sliderBuilder min.
	super setValue: newValue.
	numberInput number: self realValue
]

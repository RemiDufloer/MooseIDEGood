Class {
	#name : #MiBooleanSetting,
	#superclass : #MiAbstractSetting,
	#category : #'MooseIDE-Settings'
}

{ #category : #ui }
MiBooleanSetting class >> checkBoxWidth [

	^ 16
]

{ #category : #'as yet unclassified' }
MiBooleanSetting class >> presenterHeight [

	^ 16
]

{ #category : #ui }
MiBooleanSetting >> buildPresenterIn: presenter [

	^ presenter newCheckBox
		  state: self currentValue;
		  help: self help;
		  whenChangedDo: [ :booleanValue | self localValue: booleanValue ];
		  yourself
]

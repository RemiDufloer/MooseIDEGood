Class {
	#name : #MiAbstractSetting,
	#superclass : #Object,
	#instVars : [
		'browserModel',
		'name',
		'label',
		'help',
		'localValue',
		'iconName'
	],
	#category : #'MooseIDE-Settings'
}

{ #category : #'instance creation' }
MiAbstractSetting class >> for: aMiBrowserModel [

	^ self new
		  browserModel: aMiBrowserModel;
		  yourself
]

{ #category : #'instance creation' }
MiAbstractSetting class >> named: aSymbol [

	^ self new
		  name: aSymbol;
		  yourself
]

{ #category : #'as yet unclassified' }
MiAbstractSetting class >> presenterHeight [

	self subclassResponsibility
]

{ #category : #accessing }
MiAbstractSetting >> browserModel: aMiBrowserModel [

	browserModel := aMiBrowserModel
]

{ #category : #ui }
MiAbstractSetting >> buildIconIn: presenter [

	^ presenter newImage image:
		  (presenter iconNamed: self iconName) yourself
]

{ #category : #ui }
MiAbstractSetting >> buildLabelIn: presenter [

	^ presenter newLabel
		  label: self label;
		  help: self help;
		  yourself
]

{ #category : #ui }
MiAbstractSetting >> buildPresenterIn: anOwnerPresenter [

	self subclassResponsibility
]

{ #category : #accessing }
MiAbstractSetting >> currentValue [

	^ localValue
]

{ #category : #accessing }
MiAbstractSetting >> globalValue [

	^ browserModel globalValueOfSetting: self name
]

{ #category : #accessing }
MiAbstractSetting >> help [

	^ help ifNil: [ '' ]
]

{ #category : #accessing }
MiAbstractSetting >> help: aString [

	help := aString
]

{ #category : #accessing }
MiAbstractSetting >> iconName [

	^ iconName ifNil: [ #configuration ]
]

{ #category : #accessing }
MiAbstractSetting >> iconName: aSymbol [

	iconName := aSymbol
]

{ #category : #accessing }
MiAbstractSetting >> initializeLocalValue: anObject [

	localValue := self globalValue ifNil: [ anObject ]
]

{ #category : #accessing }
MiAbstractSetting >> label [

	^ label ifNil: [ '' ]
]

{ #category : #accessing }
MiAbstractSetting >> label: aString [

	label := aString
]

{ #category : #accessing }
MiAbstractSetting >> localValue: anObject [

	localValue := anObject
]

{ #category : #accessing }
MiAbstractSetting >> name [

	^ name
]

{ #category : #accessing }
MiAbstractSetting >> name: aSymbol [

	name := aSymbol
]

{ #category : #ui }
MiAbstractSetting >> presenterHeight [

	^ self class presenterHeight
]

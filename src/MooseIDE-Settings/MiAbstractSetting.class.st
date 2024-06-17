Class {
	#name : #MiAbstractSetting,
	#superclass : #Object,
	#instVars : [
		'localValue'
	],
	#classInstVars : [
		'globalValue'
	],
	#category : #'MooseIDE-Settings'
}

{ #category : #settings }
MiAbstractSetting class >> buildSettingNodeOn: aBuilder [

	^ (aBuilder setting: self settingID)
		  selector: self settingSelector;
		  label: self label;
		  description: self description;
		  iconName: self iconName
]

{ #category : #accessing }
MiAbstractSetting class >> defaultValue [

	self subclassResponsibility
]

{ #category : #specs }
MiAbstractSetting class >> description [

	self subclassResponsibility
]

{ #category : #accessing }
MiAbstractSetting class >> globalValue [

	^ globalValue ifNil: [ globalValue := self defaultValue ]
]

{ #category : #accessing }
MiAbstractSetting class >> globalValue: anObject [

	globalValue := anObject
]

{ #category : #accessing }
MiAbstractSetting class >> iconName [

	^ #configuration
]

{ #category : #specs }
MiAbstractSetting class >> label [

	^ ''
]

{ #category : #specs }
MiAbstractSetting class >> presenterHeight [

	self subclassResponsibility
]

{ #category : #specs }
MiAbstractSetting class >> settingID [

	self subclassResponsibility
]

{ #category : #specs }
MiAbstractSetting class >> settingSelector [

	^ #globalValue
]

{ #category : #ui }
MiAbstractSetting >> buildIconIn: presenter [

	^ presenter newImage
		  image: (presenter iconNamed: self class iconName);
		  yourself
]

{ #category : #ui }
MiAbstractSetting >> buildLabelIn: presenter [

	^ presenter newLabel
		  label: self class label;
		  help: self class description;
		  yourself
]

{ #category : #ui }
MiAbstractSetting >> buildPresenterIn: anOwnerPresenter [

	self subclassResponsibility
]

{ #category : #accessing }
MiAbstractSetting >> currentValue [

	^ localValue ifNil: [ self class globalValue ]
]

{ #category : #accessing }
MiAbstractSetting >> localValue: anObject [

	localValue := anObject
]

{ #category : #ui }
MiAbstractSetting >> presenterHeight [

	^ self class presenterHeight
]

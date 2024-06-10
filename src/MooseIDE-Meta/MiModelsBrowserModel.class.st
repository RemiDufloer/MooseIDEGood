"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	model:		<Object>
	selected:		<Object>


    Implementation Points
"
Class {
	#name : #MiModelsBrowserModel,
	#superclass : #MiAbstractModel,
	#instVars : [
		'mooseModelsList',
		'selected',
		'settings'
	],
	#category : #'MooseIDE-Meta-ModelsBrowser'
}

{ #category : #updating }
MiModelsBrowserModel >> allModelRootBrowser [

	^ browser application allBrowsers: MiModelsBrowser
]

{ #category : #settings }
MiModelsBrowserModel >> autoImportSetting [

	^ (settings at: #modelAutoImportSetting) currentValue
]

{ #category : #accessing }
MiModelsBrowserModel >> availableMooseModels [

	^ MooseModel root allModels
]

{ #category : #accessing }
MiModelsBrowserModel >> currentMooseModel [

	^ self selected
]

{ #category : #accessing }
MiModelsBrowserModel >> entities [

	^ mooseModelsList
]

{ #category : #'accessing - tests' }
MiModelsBrowserModel >> entities: aList [

	mooseModelsList := aList
]

{ #category : #settings }
MiModelsBrowserModel >> globalValueOfSetting: aSymbol [

	self flag: 'Horrible. Faire appel au global for real'.
	^ (settings at: aSymbol ifAbsent: [ ^ false ]) defaultValue
]

{ #category : #initialization }
MiModelsBrowserModel >> initialize [

	super initialize.
	mooseModelsList := self availableMooseModels.

	self initializeSettings 
]

{ #category : #initialization }
MiModelsBrowserModel >> initializeSettings [

	settings := Dictionary new.

	settings at: #filterStubsSetting put: (MiBooleanSetting new
			 browserModel: self;
			 name: #filterStubsSetting;
			 initializeLocalValue: true;
			 iconName: #mooseFilter;
			 label: 'Filter out stubs?';
			 help:
				 'If set to true, clicking Propagate will send to the bus a MooseGroup containing only the entities that are not stub.
If set to false, send the entire model.';
			 yourself).

	settings at: #modelAutoImportSetting put: (MiBooleanSetting new
			 browserModel: self;
			 name: #modelAutoImportSetting;
			 initializeLocalValue: false;
			 iconName: #mooseDragAndDrop;
			 label: 'Automatically import drag & drop files?';
			 help: 'Behavior when a model file is droped: 
If set to true, the model will be automatically imported if possible.
If set to false, the import dialog will open, configured according to the file.';
			 yourself)
]

{ #category : #settings }
MiModelsBrowserModel >> openSettings [

	^ (MiLocalSettingsPresenter on: self) openDialog
]

{ #category : #accessing }
MiModelsBrowserModel >> selected [

	^ selected
]

{ #category : #accessing }
MiModelsBrowserModel >> selected: anObject [
	selected := anObject.
	browser updateToolbar
]

{ #category : #accessing }
MiModelsBrowserModel >> selectedModel [

	^ self shouldFilterStubs
		  ifTrue: [
			  self selected ifNotNil: [ :selectedModel |
				  (selectedModel reject: [ :each | each isStub ]) asMooseGroup ] ]
		  ifFalse: [ self selected ]
]

{ #category : #'accessing - tests' }
MiModelsBrowserModel >> settings [

	^ settings values sorted: #name ascending
]

{ #category : #settings }
MiModelsBrowserModel >> shouldFilterStubs [

	^ (settings at: #filterStubsSetting) currentValue
]

{ #category : #updating }
MiModelsBrowserModel >> updateForNewModel: aMooseModel [

	self allModelRootBrowser do: [ :modelBrowser |
		modelBrowser updateList ].
	self selected: aMooseModel
]

{ #category : #updating }
MiModelsBrowserModel >> updateMooseModelsList [

	mooseModelsList := self availableMooseModels.
	browser listOfMooseModels: mooseModelsList
]

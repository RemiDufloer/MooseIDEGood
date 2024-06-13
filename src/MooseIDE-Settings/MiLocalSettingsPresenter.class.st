Class {
	#name : #MiLocalSettingsPresenter,
	#superclass : #MiPresenter,
	#instVars : [
		'browserModel'
	],
	#category : #'MooseIDE-Settings'
}

{ #category : #accessing }
MiLocalSettingsPresenter class >> itemSpacing [

	^ 15
]

{ #category : #accessing }
MiLocalSettingsPresenter class >> minimumHeight [

	^ 80
]

{ #category : #initialization }
MiLocalSettingsPresenter >> computeExtentFor: aSpWindowPresenter [

	^ aSpWindowPresenter initialExtent x @ (self class minimumHeight
	   + (browserModel settings sumNumbers: [ :setting |
			    setting presenterHeight ])
	   + ((browserModel settings size + 1) * self class itemSpacing))
]

{ #category : #initialization }
MiLocalSettingsPresenter >> initializeWindow: aSpWindowPresenter [

	aSpWindowPresenter initialExtent:
		(self computeExtentFor: aSpWindowPresenter).

	aSpWindowPresenter title: browserModel browser title , ' settings'
]

{ #category : #accessing }
MiLocalSettingsPresenter >> layout [

	^ SpGridLayout build: [ :builder |
		  browserModel settings
			  do: [ :setting |
				  builder
					  add: (setting buildIconIn: self);
					  add: (setting buildLabelIn: self);
					  add: (setting buildPresenterIn: self) ]
			  separatedBy: [ builder nextRow ].
		  builder beColumnNotHomogeneous ]
]

{ #category : #showing }
MiLocalSettingsPresenter >> openDialog [

	^ super openDialog
		  okAction: [  ];
		  cancelAction: [  ];
		  yourself
]

{ #category : #'accessing - model' }
MiLocalSettingsPresenter >> setModelBeforeInitialization: aMiBrowserModel [

	browserModel := aMiBrowserModel
]

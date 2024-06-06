Class {
	#name : #MiLocalSettingsPresenter,
	#superclass : #MiPresenter,
	#instVars : [
		'browserModel'
	],
	#category : #'MooseIDE-Settings'
}

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

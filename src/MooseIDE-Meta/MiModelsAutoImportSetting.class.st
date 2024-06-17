Class {
	#name : #MiModelsAutoImportSetting,
	#superclass : #MiBooleanSetting,
	#category : #'MooseIDE-Meta-ModelsBrowser'
}

{ #category : #settings }
MiModelsAutoImportSetting class >> buildSettingNodeOn: aBuilder [

	<systemsettings>
	(super buildSettingNodeOn: aBuilder)
		parent: MiModelsBrowser menuItem;
		target: self
]

{ #category : #specs }
MiModelsAutoImportSetting class >> defaultValue [

	^ false
]

{ #category : #specs }
MiModelsAutoImportSetting class >> description [

	^ 'Behavior when a model file is droped: 
If set to true, the model will be automatically imported if possible.
If set to false, the import dialog will open, configured according to the file.'
]

{ #category : #specs }
MiModelsAutoImportSetting class >> iconName [

	^ #mooseDragAndDrop
]

{ #category : #specs }
MiModelsAutoImportSetting class >> label [

	^ 'Automatically import drag & drop files'
]

{ #category : #specs }
MiModelsAutoImportSetting class >> settingID [

	^ #autoImportModelSetting
]

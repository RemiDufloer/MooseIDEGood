Class {
	#name : #MiModelsFilterStubsSetting,
	#superclass : #MiBooleanSetting,
	#category : #'MooseIDE-Meta-ModelsBrowser'
}

{ #category : #settings }
MiModelsFilterStubsSetting class >> buildSettingNodeOn: aBuilder [

	<systemsettings>
	(super buildSettingNodeOn: aBuilder)
		parent: MiModelsBrowser menuItem;
		target: self
]

{ #category : #accessing }
MiModelsFilterStubsSetting class >> defaultValue [

	^ true
]

{ #category : #specs }
MiModelsFilterStubsSetting class >> description [

	^ 'If set to true, clicking Propagate will send to the bus a MooseGroup containing only the entities that are not stub.
If set to false, send the entire model.'
]

{ #category : #specs }
MiModelsFilterStubsSetting class >> iconName [

	^ #mooseFilter
]

{ #category : #specs }
MiModelsFilterStubsSetting class >> label [

	^ 'Filter out stubs?'
]

{ #category : #specs }
MiModelsFilterStubsSetting class >> settingID [

	^ #filterStubs
]

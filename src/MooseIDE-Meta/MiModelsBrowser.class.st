"
** Moose IDE entrypoint **
Shows installed models and allows model installation.

- Accepted entities: Does not apply.
- Highlight: <TODO> Could highlight the model containing the received entity.
- Propagate: The selected model.

<TODO> Add features available in MoosePanel.
"
Class {
	#name : #MiModelsBrowser,
	#superclass : #MiAbstractBrowser,
	#instVars : [
		'modelFilteringList'
	],
	#category : #'MooseIDE-Meta-ModelsBrowser'
}

{ #category : #keymaps }
MiModelsBrowser class >> browserKey [

	^ $m
]

{ #category : #commands }
MiModelsBrowser class >> buildModelCommandsGroupWith: presenterInstance [

	^ CmCommandGroup forSpec beRoot
		  register: (MiInspectCommand forSpecContext: presenterInstance);
		  register: (MiPropagateCommand forSpecContext: presenterInstance);
		  register:
			  (MiModelExportCommand asCommandGroupWith: presenterInstance);
		  register:
			  (MiModelUtilityCommand asCommandGroupWith: presenterInstance)
]

{ #category : #settings }
MiModelsBrowser class >> buildSettingGroupOn: aBuilder [

	<systemsettings>
	(aBuilder group: self menuItem)
		parent: #mooseIDE;
		label: self title , ' settings';
		description: self description;
		iconName: self menuIconName
]

{ #category : #accessing }
MiModelsBrowser class >> description [

	^ 'Settings for the Models browser'
]

{ #category : #testing }
MiModelsBrowser class >> isModelImporter [
	^true
]

{ #category : #'world menu' }
MiModelsBrowser class >> menuCommandOn: aBuilder [

	<worldMenu>
	^ self buildMenuItemIn: aBuilder
]

{ #category : #'world menu' }
MiModelsBrowser class >> menuIconName [

	^ #mooseNavigation
]

{ #category : #'world menu' }
MiModelsBrowser class >> menuItem [

	^ #ModelsBrowser
]

{ #category : #'world menu' }
MiModelsBrowser class >> menuPriority [

	^ self menuMainToolsPriority + 2
]

{ #category : #'instance creation' }
MiModelsBrowser class >> newModel [

	^ MiModelsBrowserModel new
]

{ #category : #'instance creation' }
MiModelsBrowser class >> open [

	<script>
	^ super open
]

{ #category : #specs }
MiModelsBrowser class >> title [

	^ 'Models browser'
]

{ #category : #specs }
MiModelsBrowser class >> windowSize [

	^ 600 @ 400
]

{ #category : #initialization }
MiModelsBrowser >> buildToolbar [

	^ self newToolbar
		  fillWith: (MiImportCommand asCommandGroupForSpecContext: self);
		  beIcons;
		  addItem: self refreshToolbarButton;
		  yourself
]

{ #category : #testing }
MiModelsBrowser >> canFollowEntity: anObject [

	^ false
]

{ #category : #testing }
MiModelsBrowser >> canTagEntities [

	"This browser manipulates models, not entities"

	^ false
]

{ #category : #layout }
MiModelsBrowser >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: self buildToolbar
		  withConstraints: [ :constraints |
			  constraints height: self class toolbarHeight ];
		  add: #modelFilteringList;
		  yourself
]

{ #category : #actions }
MiModelsBrowser >> followEntity: anEntity [

	"Nothing to do"

	
]

{ #category : #actions }
MiModelsBrowser >> handleDropFile: aFileReference [

	self model autoImportSetting
		ifTrue: [
		self importFromFileUI handleDropFileAndImport: aFileReference ]
		ifFalse: [
			self importFromFileUI
				openDialog;
				handleDropFile: aFileReference ]
]

{ #category : #testing }
MiModelsBrowser >> hasSettings [

	^ true
]

{ #category : #accessing }
MiModelsBrowser >> importFromFileUI [

	^ MiImportModelFromFileDialog on: self
]

{ #category : #initialization }
MiModelsBrowser >> initializePresenters [

	modelFilteringList := self newFilteringList.
	self listOfMooseModels: specModel entities.

	modelFilteringList
		display: [ :mooseModel | mooseModel name ];
		contextMenu: [ self modelCommandsGroup asMenuPresenter ].

	modelFilteringList whenSelectionChangedDo: [ :selected |
		specModel selected: selected selectedItem ]
]

{ #category : #updating }
MiModelsBrowser >> listOfMooseModels: aList [

	modelFilteringList items: aList.
	
]

{ #category : #accessing }
MiModelsBrowser >> miSelectedItem [

	^ specModel selected
]

{ #category : #accessing }
MiModelsBrowser >> miSelectedItemToPropagate [

	^ specModel selectedModel
]

{ #category : #commands }
MiModelsBrowser >> modelCommandsGroup [

	^ self class buildModelCommandsGroupWith: self
]

{ #category : #initialization }
MiModelsBrowser >> refreshToolbarButton [

	^ SpToolbarButtonPresenter new
		  icon: (self iconNamed: #smallUpdate);
		  help: 'Refresh list';
		  action: [ self updateList ];
		  yourself
]

{ #category : #'accessing - tests' }
MiModelsBrowser >> settingsItem [

	^ specModel settings
]

{ #category : #updating }
MiModelsBrowser >> updateForNewModel: aModel [
	specModel updateForNewModel: aModel

]

{ #category : #updating }
MiModelsBrowser >> updateList [

	specModel updateMooseModelsList.
]

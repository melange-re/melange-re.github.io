
# Module `Dom`

```ocaml
type _baseClass
```
```reasonml
type _baseClass;
```
```ocaml
type animation
```
```reasonml
type animation;
```
```ocaml
type cssStyleDeclaration
```
```reasonml
type cssStyleDeclaration;
```
```ocaml
type cssStyleSheet
```
```reasonml
type cssStyleSheet;
```
```ocaml
type 'a eventTarget_like
```
```reasonml
type eventTarget_like('a);
```
```ocaml
type eventTarget = _baseClass eventTarget_like
```
```reasonml
type eventTarget = eventTarget_like(_baseClass);
```
```ocaml
type _messagePort
```
```reasonml
type _messagePort;
```
```ocaml
type messagePort = _messagePort eventTarget_like
```
```reasonml
type messagePort = eventTarget_like(_messagePort);
```
```ocaml
type _serviceWorker
```
```reasonml
type _serviceWorker;
```
```ocaml
type serviceWorker = _serviceWorker eventTarget_like
```
```reasonml
type serviceWorker = eventTarget_like(_serviceWorker);
```
```ocaml
type _worker
```
```reasonml
type _worker;
```
```ocaml
type worker = _worker eventTarget_like
```
```reasonml
type worker = eventTarget_like(_worker);
```
```ocaml
type 'a _workerGlobalScope
```
```reasonml
type _workerGlobalScope('a);
```
```ocaml
type workerGlobalScope = _baseClass _workerGlobalScope eventTarget_like
```
```reasonml
type workerGlobalScope = eventTarget_like(_workerGlobalScope(_baseClass));
```
```ocaml
type _dedicatedWorkerGlobalScope
```
```reasonml
type _dedicatedWorkerGlobalScope;
```
```ocaml
type dedicatedWorkerGlobalScope =
  _dedicatedWorkerGlobalScope _workerGlobalScope eventTarget_like
```
```reasonml
type dedicatedWorkerGlobalScope =
  eventTarget_like(_workerGlobalScope(_dedicatedWorkerGlobalScope));
```
```ocaml
type _serviceWorkerGlobalScope
```
```reasonml
type _serviceWorkerGlobalScope;
```
```ocaml
type serviceWorkerGlobalScope =
  _serviceWorkerGlobalScope _workerGlobalScope eventTarget_like
```
```reasonml
type serviceWorkerGlobalScope =
  eventTarget_like(_workerGlobalScope(_serviceWorkerGlobalScope));
```
```ocaml
type _sharedWorkerGlobalScope
```
```reasonml
type _sharedWorkerGlobalScope;
```
```ocaml
type sharedWorkerGlobalScope =
  _sharedWorkerGlobalScope _workerGlobalScope eventTarget_like
```
```reasonml
type sharedWorkerGlobalScope =
  eventTarget_like(_workerGlobalScope(_sharedWorkerGlobalScope));
```
```ocaml
type 'a _node
```
```reasonml
type _node('a);
```
```ocaml
type 'a node_like = 'a _node eventTarget_like
```
```reasonml
type node_like('a) = eventTarget_like(_node('a));
```
```ocaml
type node = _baseClass node_like
```
```reasonml
type node = node_like(_baseClass);
```
```ocaml
type _attr
```
```reasonml
type _attr;
```
```ocaml
type attr = _attr node_like
```
```reasonml
type attr = node_like(_attr);
```
```ocaml
type 'a _characterData
```
```reasonml
type _characterData('a);
```
```ocaml
type 'a characterData_like = 'a _characterData node_like
```
```reasonml
type characterData_like('a) = node_like(_characterData('a));
```
```ocaml
type characterData = _baseClass characterData_like
```
```reasonml
type characterData = characterData_like(_baseClass);
```
```ocaml
type _cdataSection
```
```reasonml
type _cdataSection;
```
```ocaml
type cdataSection = _cdataSection characterData_like
```
```reasonml
type cdataSection = characterData_like(_cdataSection);
```
```ocaml
type _comment
```
```reasonml
type _comment;
```
```ocaml
type comment = _comment characterData_like
```
```reasonml
type comment = characterData_like(_comment);
```
```ocaml
type 'a _document
```
```reasonml
type _document('a);
```
```ocaml
type 'a document_like = 'a _document node_like
```
```reasonml
type document_like('a) = node_like(_document('a));
```
```ocaml
type document = _baseClass document_like
```
```reasonml
type document = document_like(_baseClass);
```
```ocaml
type _documentFragment
```
```reasonml
type _documentFragment;
```
```ocaml
type documentFragment = _documentFragment node_like
```
```reasonml
type documentFragment = node_like(_documentFragment);
```
```ocaml
type _documentType
```
```reasonml
type _documentType;
```
```ocaml
type documentType = _documentType node_like
```
```reasonml
type documentType = node_like(_documentType);
```
```ocaml
type domImplementation
```
```reasonml
type domImplementation;
```
```ocaml
type 'a _element
```
```reasonml
type _element('a);
```
```ocaml
type 'a element_like = 'a _element node_like
```
```reasonml
type element_like('a) = node_like(_element('a));
```
```ocaml
type element = _baseClass element_like
```
```reasonml
type element = element_like(_baseClass);
```
```ocaml
type htmlCollection
```
```reasonml
type htmlCollection;
```
```ocaml
type htmlFormControlsCollection
```
```reasonml
type htmlFormControlsCollection;
```
```ocaml
type htmlOptionsCollection
```
```reasonml
type htmlOptionsCollection;
```
```ocaml
type intersectionObserver
```
```reasonml
type intersectionObserver;
```
```ocaml
type intersectionObserverEntry
```
```reasonml
type intersectionObserverEntry;
```
```ocaml
type mutationObserver
```
```reasonml
type mutationObserver;
```
```ocaml
type mutationRecord
```
```reasonml
type mutationRecord;
```
```ocaml
type performanceObserver
```
```reasonml
type performanceObserver;
```
```ocaml
type performanceObserverEntryList
```
```reasonml
type performanceObserverEntryList;
```
```ocaml
type reportingObserver
```
```reasonml
type reportingObserver;
```
```ocaml
type reportingObserverOptions
```
```reasonml
type reportingObserverOptions;
```
```ocaml
type resizeObserver
```
```reasonml
type resizeObserver;
```
```ocaml
type resizeObserverEntry
```
```reasonml
type resizeObserverEntry;
```
```ocaml
type namedNodeMap
```
```reasonml
type namedNodeMap;
```
```ocaml
type nodeList
```
```reasonml
type nodeList;
```
```ocaml
type radioNodeList
```
```reasonml
type radioNodeList;
```
```ocaml
type processingInstruction
```
```reasonml
type processingInstruction;
```
```ocaml
type _shadowRoot
```
```reasonml
type _shadowRoot;
```
```ocaml
type shadowRoot = _shadowRoot node_like
```
```reasonml
type shadowRoot = node_like(_shadowRoot);
```
```ocaml
type _text
```
```reasonml
type _text;
```
```ocaml
type text = _text characterData_like
```
```reasonml
type text = characterData_like(_text);
```
```ocaml
type domRect
```
```reasonml
type domRect;
```
```ocaml
type dataTransfer
```
```reasonml
type dataTransfer;
```
```ocaml
type domStringMap
```
```reasonml
type domStringMap;
```
```ocaml
type history
```
```reasonml
type history;
```
```ocaml
type _htmlDocument
```
```reasonml
type _htmlDocument;
```
```ocaml
type htmlDocument = _htmlDocument document_like
```
```reasonml
type htmlDocument = document_like(_htmlDocument);
```
```ocaml
type 'a _htmlElement
```
```reasonml
type _htmlElement('a);
```
```ocaml
type 'a htmlElement_like = 'a _htmlElement element_like
```
```reasonml
type htmlElement_like('a) = element_like(_htmlElement('a));
```
```ocaml
type htmlElement = _baseClass htmlElement_like
```
```reasonml
type htmlElement = htmlElement_like(_baseClass);
```
```ocaml
type _htmlAnchorElement
```
```reasonml
type _htmlAnchorElement;
```
```ocaml
type htmlAnchorElement = _htmlAnchorElement htmlElement_like
```
```reasonml
type htmlAnchorElement = htmlElement_like(_htmlAnchorElement);
```
```ocaml
type _htmlAreaElement
```
```reasonml
type _htmlAreaElement;
```
```ocaml
type htmlAreaElement = _htmlAreaElement htmlElement_like
```
```reasonml
type htmlAreaElement = htmlElement_like(_htmlAreaElement);
```
```ocaml
type _htmlAudioElement
```
```reasonml
type _htmlAudioElement;
```
```ocaml
type htmlAudioElement = _htmlAudioElement htmlElement_like
```
```reasonml
type htmlAudioElement = htmlElement_like(_htmlAudioElement);
```
```ocaml
type _htmlBaseElement
```
```reasonml
type _htmlBaseElement;
```
```ocaml
type htmlBaseElement = _htmlBaseElement htmlElement_like
```
```reasonml
type htmlBaseElement = htmlElement_like(_htmlBaseElement);
```
```ocaml
type _htmlBodyElement
```
```reasonml
type _htmlBodyElement;
```
```ocaml
type htmlBodyElement = _htmlBodyElement htmlElement_like
```
```reasonml
type htmlBodyElement = htmlElement_like(_htmlBodyElement);
```
```ocaml
type _htmlBrElement
```
```reasonml
type _htmlBrElement;
```
```ocaml
type htmlBrElement = _htmlBrElement htmlElement_like
```
```reasonml
type htmlBrElement = htmlElement_like(_htmlBrElement);
```
```ocaml
type _htmlButtonElement
```
```reasonml
type _htmlButtonElement;
```
```ocaml
type htmlButtonElement = _htmlButtonElement htmlElement_like
```
```reasonml
type htmlButtonElement = htmlElement_like(_htmlButtonElement);
```
```ocaml
type _htmlCanvasElement
```
```reasonml
type _htmlCanvasElement;
```
```ocaml
type htmlCanvasElement = _htmlCanvasElement htmlElement_like
```
```reasonml
type htmlCanvasElement = htmlElement_like(_htmlCanvasElement);
```
```ocaml
type _htmlDataElement
```
```reasonml
type _htmlDataElement;
```
```ocaml
type htmlDataElement = _htmlDataElement htmlElement_like
```
```reasonml
type htmlDataElement = htmlElement_like(_htmlDataElement);
```
```ocaml
type _htmlDataListElement
```
```reasonml
type _htmlDataListElement;
```
```ocaml
type htmlDataListElement = _htmlDataListElement htmlElement_like
```
```reasonml
type htmlDataListElement = htmlElement_like(_htmlDataListElement);
```
```ocaml
type _htmlDialogElement
```
```reasonml
type _htmlDialogElement;
```
```ocaml
type htmlDialogElement = _htmlDialogElement htmlElement_like
```
```reasonml
type htmlDialogElement = htmlElement_like(_htmlDialogElement);
```
```ocaml
type _htmlDivElement
```
```reasonml
type _htmlDivElement;
```
```ocaml
type htmlDivElement = _htmlDivElement htmlElement_like
```
```reasonml
type htmlDivElement = htmlElement_like(_htmlDivElement);
```
```ocaml
type _htmlDlistElement
```
```reasonml
type _htmlDlistElement;
```
```ocaml
type htmlDlistElement = _htmlDlistElement htmlElement_like
```
```reasonml
type htmlDlistElement = htmlElement_like(_htmlDlistElement);
```
```ocaml
type _htmlEmbedElement
```
```reasonml
type _htmlEmbedElement;
```
```ocaml
type htmlEmbedElement = _htmlEmbedElement htmlElement_like
```
```reasonml
type htmlEmbedElement = htmlElement_like(_htmlEmbedElement);
```
```ocaml
type _htmlFieldSetElement
```
```reasonml
type _htmlFieldSetElement;
```
```ocaml
type htmlFieldSetElement = _htmlFieldSetElement htmlElement_like
```
```reasonml
type htmlFieldSetElement = htmlElement_like(_htmlFieldSetElement);
```
```ocaml
type _htmlFormElement
```
```reasonml
type _htmlFormElement;
```
```ocaml
type htmlFormElement = _htmlFormElement htmlElement_like
```
```reasonml
type htmlFormElement = htmlElement_like(_htmlFormElement);
```
```ocaml
type _htmlHeadElement
```
```reasonml
type _htmlHeadElement;
```
```ocaml
type htmlHeadElement = _htmlHeadElement htmlElement_like
```
```reasonml
type htmlHeadElement = htmlElement_like(_htmlHeadElement);
```
```ocaml
type _htmlHeadingElement
```
```reasonml
type _htmlHeadingElement;
```
```ocaml
type htmlHeadingElement = _htmlHeadingElement htmlElement_like
```
```reasonml
type htmlHeadingElement = htmlElement_like(_htmlHeadingElement);
```
```ocaml
type _htmlHrElement
```
```reasonml
type _htmlHrElement;
```
```ocaml
type htmlHrElement = _htmlHrElement htmlElement_like
```
```reasonml
type htmlHrElement = htmlElement_like(_htmlHrElement);
```
```ocaml
type _htmlHtmlElement
```
```reasonml
type _htmlHtmlElement;
```
```ocaml
type htmlHtmlElement = _htmlHtmlElement htmlElement_like
```
```reasonml
type htmlHtmlElement = htmlElement_like(_htmlHtmlElement);
```
```ocaml
type _htmlIframeElement
```
```reasonml
type _htmlIframeElement;
```
```ocaml
type htmlIframeElement = _htmlIframeElement htmlElement_like
```
```reasonml
type htmlIframeElement = htmlElement_like(_htmlIframeElement);
```
```ocaml
type _htmlImageElement
```
```reasonml
type _htmlImageElement;
```
```ocaml
type htmlImageElement = _htmlImageElement htmlElement_like
```
```reasonml
type htmlImageElement = htmlElement_like(_htmlImageElement);
```
```ocaml
type _htmlInputElement
```
```reasonml
type _htmlInputElement;
```
```ocaml
type htmlInputElement = _htmlInputElement htmlElement_like
```
```reasonml
type htmlInputElement = htmlElement_like(_htmlInputElement);
```
```ocaml
type _htmlLabelElement
```
```reasonml
type _htmlLabelElement;
```
```ocaml
type htmlLabelElement = _htmlLabelElement htmlElement_like
```
```reasonml
type htmlLabelElement = htmlElement_like(_htmlLabelElement);
```
```ocaml
type _htmlLegendElement
```
```reasonml
type _htmlLegendElement;
```
```ocaml
type htmlLegendElement = _htmlLegendElement htmlElement_like
```
```reasonml
type htmlLegendElement = htmlElement_like(_htmlLegendElement);
```
```ocaml
type _htmlLiElement
```
```reasonml
type _htmlLiElement;
```
```ocaml
type htmlLiElement = _htmlLiElement htmlElement_like
```
```reasonml
type htmlLiElement = htmlElement_like(_htmlLiElement);
```
```ocaml
type _htmlLinkElement
```
```reasonml
type _htmlLinkElement;
```
```ocaml
type htmlLinkElement = _htmlLinkElement htmlElement_like
```
```reasonml
type htmlLinkElement = htmlElement_like(_htmlLinkElement);
```
```ocaml
type _htmlMapElement
```
```reasonml
type _htmlMapElement;
```
```ocaml
type htmlMapElement = _htmlMapElement htmlElement_like
```
```reasonml
type htmlMapElement = htmlElement_like(_htmlMapElement);
```
```ocaml
type _htmlMediaElement
```
```reasonml
type _htmlMediaElement;
```
```ocaml
type htmlMediaElement = _htmlMediaElement htmlElement_like
```
```reasonml
type htmlMediaElement = htmlElement_like(_htmlMediaElement);
```
```ocaml
type _htmlMenuElement
```
```reasonml
type _htmlMenuElement;
```
```ocaml
type htmlMenuElement = _htmlMenuElement htmlElement_like
```
```reasonml
type htmlMenuElement = htmlElement_like(_htmlMenuElement);
```
```ocaml
type _htmlMetaElement
```
```reasonml
type _htmlMetaElement;
```
```ocaml
type htmlMetaElement = _htmlMetaElement htmlElement_like
```
```reasonml
type htmlMetaElement = htmlElement_like(_htmlMetaElement);
```
```ocaml
type _htmlMeterElement
```
```reasonml
type _htmlMeterElement;
```
```ocaml
type htmlMeterElement = _htmlMeterElement htmlElement_like
```
```reasonml
type htmlMeterElement = htmlElement_like(_htmlMeterElement);
```
```ocaml
type _htmlModElement
```
```reasonml
type _htmlModElement;
```
```ocaml
type htmlModElement = _htmlModElement htmlElement_like
```
```reasonml
type htmlModElement = htmlElement_like(_htmlModElement);
```
```ocaml
type _htmlOListElement
```
```reasonml
type _htmlOListElement;
```
```ocaml
type htmlOListElement = _htmlOListElement htmlElement_like
```
```reasonml
type htmlOListElement = htmlElement_like(_htmlOListElement);
```
```ocaml
type _htmlObjectElement
```
```reasonml
type _htmlObjectElement;
```
```ocaml
type htmlObjectElement = _htmlObjectElement htmlElement_like
```
```reasonml
type htmlObjectElement = htmlElement_like(_htmlObjectElement);
```
```ocaml
type _htmlOptGroupElement
```
```reasonml
type _htmlOptGroupElement;
```
```ocaml
type htmlOptGroupElement = _htmlOptGroupElement htmlElement_like
```
```reasonml
type htmlOptGroupElement = htmlElement_like(_htmlOptGroupElement);
```
```ocaml
type _htmlOptionElement
```
```reasonml
type _htmlOptionElement;
```
```ocaml
type htmlOptionElement = _htmlOptionElement htmlElement_like
```
```reasonml
type htmlOptionElement = htmlElement_like(_htmlOptionElement);
```
```ocaml
type _htmlOutputElement
```
```reasonml
type _htmlOutputElement;
```
```ocaml
type htmlOutputElement = _htmlOutputElement htmlElement_like
```
```reasonml
type htmlOutputElement = htmlElement_like(_htmlOutputElement);
```
```ocaml
type _htmlParagraphElement
```
```reasonml
type _htmlParagraphElement;
```
```ocaml
type htmlParagraphElement = _htmlParagraphElement htmlElement_like
```
```reasonml
type htmlParagraphElement = htmlElement_like(_htmlParagraphElement);
```
```ocaml
type _htmlParamElement
```
```reasonml
type _htmlParamElement;
```
```ocaml
type htmlParamElement = _htmlParamElement htmlElement_like
```
```reasonml
type htmlParamElement = htmlElement_like(_htmlParamElement);
```
```ocaml
type _htmlPreElement
```
```reasonml
type _htmlPreElement;
```
```ocaml
type htmlPreElement = _htmlPreElement htmlElement_like
```
```reasonml
type htmlPreElement = htmlElement_like(_htmlPreElement);
```
```ocaml
type _htmlProgressElement
```
```reasonml
type _htmlProgressElement;
```
```ocaml
type htmlProgressElement = _htmlProgressElement htmlElement_like
```
```reasonml
type htmlProgressElement = htmlElement_like(_htmlProgressElement);
```
```ocaml
type _htmlQuoteElement
```
```reasonml
type _htmlQuoteElement;
```
```ocaml
type htmlQuoteElement = _htmlQuoteElement htmlElement_like
```
```reasonml
type htmlQuoteElement = htmlElement_like(_htmlQuoteElement);
```
```ocaml
type _htmlScriptElement
```
```reasonml
type _htmlScriptElement;
```
```ocaml
type htmlScriptElement = _htmlScriptElement htmlElement_like
```
```reasonml
type htmlScriptElement = htmlElement_like(_htmlScriptElement);
```
```ocaml
type _htmlSelectElement
```
```reasonml
type _htmlSelectElement;
```
```ocaml
type htmlSelectElement = _htmlSelectElement htmlElement_like
```
```reasonml
type htmlSelectElement = htmlElement_like(_htmlSelectElement);
```
```ocaml
type _htmlSlotElement
```
```reasonml
type _htmlSlotElement;
```
```ocaml
type htmlSlotElement = _htmlSlotElement htmlElement_like
```
```reasonml
type htmlSlotElement = htmlElement_like(_htmlSlotElement);
```
```ocaml
type _htmlSourceElement
```
```reasonml
type _htmlSourceElement;
```
```ocaml
type htmlSourceElement = _htmlSourceElement htmlElement_like
```
```reasonml
type htmlSourceElement = htmlElement_like(_htmlSourceElement);
```
```ocaml
type _htmlSpanElement
```
```reasonml
type _htmlSpanElement;
```
```ocaml
type htmlSpanElement = _htmlSpanElement htmlElement_like
```
```reasonml
type htmlSpanElement = htmlElement_like(_htmlSpanElement);
```
```ocaml
type _htmlStyleElement
```
```reasonml
type _htmlStyleElement;
```
```ocaml
type htmlStyleElement = _htmlStyleElement htmlElement_like
```
```reasonml
type htmlStyleElement = htmlElement_like(_htmlStyleElement);
```
```ocaml
type _htmlTableCaptionElement
```
```reasonml
type _htmlTableCaptionElement;
```
```ocaml
type htmlTableCaptionElement = _htmlTableCaptionElement htmlElement_like
```
```reasonml
type htmlTableCaptionElement = htmlElement_like(_htmlTableCaptionElement);
```
```ocaml
type _htmlTableCellElement
```
```reasonml
type _htmlTableCellElement;
```
```ocaml
type htmlTableCellElement = _htmlTableCellElement htmlElement_like
```
```reasonml
type htmlTableCellElement = htmlElement_like(_htmlTableCellElement);
```
```ocaml
type _htmlTableColElement
```
```reasonml
type _htmlTableColElement;
```
```ocaml
type htmlTableColElement = _htmlTableColElement htmlElement_like
```
```reasonml
type htmlTableColElement = htmlElement_like(_htmlTableColElement);
```
```ocaml
type _htmlTableDataCellElement
```
```reasonml
type _htmlTableDataCellElement;
```
```ocaml
type htmlTableDataCellElement = _htmlTableDataCellElement htmlElement_like
```
```reasonml
type htmlTableDataCellElement = htmlElement_like(_htmlTableDataCellElement);
```
```ocaml
type _htmlTableElement
```
```reasonml
type _htmlTableElement;
```
```ocaml
type htmlTableElement = _htmlTableElement htmlElement_like
```
```reasonml
type htmlTableElement = htmlElement_like(_htmlTableElement);
```
```ocaml
type _htmlTableHeaderCellElement
```
```reasonml
type _htmlTableHeaderCellElement;
```
```ocaml
type htmlTableHeaderCellElement = _htmlTableHeaderCellElement htmlElement_like
```
```reasonml
type htmlTableHeaderCellElement = htmlElement_like(_htmlTableHeaderCellElement);
```
```ocaml
type _htmlTableRowElement
```
```reasonml
type _htmlTableRowElement;
```
```ocaml
type htmlTableRowElement = _htmlTableRowElement htmlElement_like
```
```reasonml
type htmlTableRowElement = htmlElement_like(_htmlTableRowElement);
```
```ocaml
type _htmlTableSectionElement
```
```reasonml
type _htmlTableSectionElement;
```
```ocaml
type htmlTableSectionElement = _htmlTableSectionElement htmlElement_like
```
```reasonml
type htmlTableSectionElement = htmlElement_like(_htmlTableSectionElement);
```
```ocaml
type _htmlTextAreaElement
```
```reasonml
type _htmlTextAreaElement;
```
```ocaml
type htmlTextAreaElement = _htmlTextAreaElement htmlElement_like
```
```reasonml
type htmlTextAreaElement = htmlElement_like(_htmlTextAreaElement);
```
```ocaml
type _htmlTimeElement
```
```reasonml
type _htmlTimeElement;
```
```ocaml
type htmlTimeElement = _htmlTimeElement htmlElement_like
```
```reasonml
type htmlTimeElement = htmlElement_like(_htmlTimeElement);
```
```ocaml
type _htmlTitleElement
```
```reasonml
type _htmlTitleElement;
```
```ocaml
type htmlTitleElement = _htmlTitleElement htmlElement_like
```
```reasonml
type htmlTitleElement = htmlElement_like(_htmlTitleElement);
```
```ocaml
type _htmlTrackElement
```
```reasonml
type _htmlTrackElement;
```
```ocaml
type htmlTrackElement = _htmlTrackElement htmlElement_like
```
```reasonml
type htmlTrackElement = htmlElement_like(_htmlTrackElement);
```
```ocaml
type _htmlUlistElement
```
```reasonml
type _htmlUlistElement;
```
```ocaml
type htmlUlistElement = _htmlUlistElement htmlElement_like
```
```reasonml
type htmlUlistElement = htmlElement_like(_htmlUlistElement);
```
```ocaml
type _htmlUnknownElement
```
```reasonml
type _htmlUnknownElement;
```
```ocaml
type htmlUnknownElement = _htmlUnknownElement htmlElement_like
```
```reasonml
type htmlUnknownElement = htmlElement_like(_htmlUnknownElement);
```
```ocaml
type _htmlVideoElement
```
```reasonml
type _htmlVideoElement;
```
```ocaml
type htmlVideoElement = _htmlVideoElement htmlElement_like
```
```reasonml
type htmlVideoElement = htmlElement_like(_htmlVideoElement);
```
```ocaml
type location
```
```reasonml
type location;
```
```ocaml
type window
```
```reasonml
type window;
```
```ocaml
type _xmlDocument
```
```reasonml
type _xmlDocument;
```
```ocaml
type xmlDocument = _xmlDocument document_like
```
```reasonml
type xmlDocument = document_like(_xmlDocument);
```
```ocaml
type 'a event_like
```
```reasonml
type event_like('a);
```
```ocaml
type event = _baseClass event_like
```
```reasonml
type event = event_like(_baseClass);
```
```ocaml
type 'a _uiEvent
```
```reasonml
type _uiEvent('a);
```
```ocaml
type 'a uiEvent_like = 'a _uiEvent event_like
```
```reasonml
type uiEvent_like('a) = event_like(_uiEvent('a));
```
```ocaml
type uiEvent = _baseClass uiEvent_like
```
```reasonml
type uiEvent = uiEvent_like(_baseClass);
```
```ocaml
type _animationEvent
```
```reasonml
type _animationEvent;
```
```ocaml
type animationEvent = _animationEvent event_like
```
```reasonml
type animationEvent = event_like(_animationEvent);
```
```ocaml
type _beforeUnloadEvent
```
```reasonml
type _beforeUnloadEvent;
```
```ocaml
type beforeUnloadEvent = _beforeUnloadEvent event_like
```
```reasonml
type beforeUnloadEvent = event_like(_beforeUnloadEvent);
```
```ocaml
type _clipboardEvent
```
```reasonml
type _clipboardEvent;
```
```ocaml
type clipboardEvent = _clipboardEvent event_like
```
```reasonml
type clipboardEvent = event_like(_clipboardEvent);
```
```ocaml
type _closeEvent
```
```reasonml
type _closeEvent;
```
```ocaml
type closeEvent = _closeEvent event_like
```
```reasonml
type closeEvent = event_like(_closeEvent);
```
```ocaml
type _compositionEvent
```
```reasonml
type _compositionEvent;
```
```ocaml
type compositionEvent = _compositionEvent uiEvent_like
```
```reasonml
type compositionEvent = uiEvent_like(_compositionEvent);
```
```ocaml
type _customEvent
```
```reasonml
type _customEvent;
```
```ocaml
type customEvent = _customEvent event_like
```
```reasonml
type customEvent = event_like(_customEvent);
```
```ocaml
type _dragEvent
```
```reasonml
type _dragEvent;
```
```ocaml
type dragEvent = _dragEvent event_like
```
```reasonml
type dragEvent = event_like(_dragEvent);
```
```ocaml
type _errorEvent
```
```reasonml
type _errorEvent;
```
```ocaml
type errorEvent = _errorEvent event_like
```
```reasonml
type errorEvent = event_like(_errorEvent);
```
```ocaml
type _focusEvent
```
```reasonml
type _focusEvent;
```
```ocaml
type focusEvent = _focusEvent uiEvent_like
```
```reasonml
type focusEvent = uiEvent_like(_focusEvent);
```
```ocaml
type _idbVersionChangeEvent
```
```reasonml
type _idbVersionChangeEvent;
```
```ocaml
type idbVersionChangeEvent = _idbVersionChangeEvent event_like
```
```reasonml
type idbVersionChangeEvent = event_like(_idbVersionChangeEvent);
```
```ocaml
type _inputEvent
```
```reasonml
type _inputEvent;
```
```ocaml
type inputEvent = _inputEvent uiEvent_like
```
```reasonml
type inputEvent = uiEvent_like(_inputEvent);
```
```ocaml
type _keyboardEvent
```
```reasonml
type _keyboardEvent;
```
```ocaml
type keyboardEvent = _keyboardEvent uiEvent_like
```
```reasonml
type keyboardEvent = uiEvent_like(_keyboardEvent);
```
```ocaml
type _messageEvent
```
```reasonml
type _messageEvent;
```
```ocaml
type messageEvent = _messageEvent event_like
```
```reasonml
type messageEvent = event_like(_messageEvent);
```
```ocaml
type 'a _mouseEvent
```
```reasonml
type _mouseEvent('a);
```
```ocaml
type 'a mouseEvent_like = 'a _mouseEvent uiEvent_like
```
```reasonml
type mouseEvent_like('a) = uiEvent_like(_mouseEvent('a));
```
```ocaml
type mouseEvent = _baseClass mouseEvent_like
```
```reasonml
type mouseEvent = mouseEvent_like(_baseClass);
```
```ocaml
type _pageTransitionEvent
```
```reasonml
type _pageTransitionEvent;
```
```ocaml
type pageTransitionEvent = _pageTransitionEvent event_like
```
```reasonml
type pageTransitionEvent = event_like(_pageTransitionEvent);
```
```ocaml
type _pointerEvent
```
```reasonml
type _pointerEvent;
```
```ocaml
type pointerEvent = _pointerEvent mouseEvent_like
```
```reasonml
type pointerEvent = mouseEvent_like(_pointerEvent);
```
```ocaml
type _popStateEvent
```
```reasonml
type _popStateEvent;
```
```ocaml
type popStateEvent = _popStateEvent event_like
```
```reasonml
type popStateEvent = event_like(_popStateEvent);
```
```ocaml
type _progressEvent
```
```reasonml
type _progressEvent;
```
```ocaml
type progressEvent = _progressEvent event_like
```
```reasonml
type progressEvent = event_like(_progressEvent);
```
```ocaml
type _relatedEvent
```
```reasonml
type _relatedEvent;
```
```ocaml
type relatedEvent = _relatedEvent event_like
```
```reasonml
type relatedEvent = event_like(_relatedEvent);
```
```ocaml
type _storageEvent
```
```reasonml
type _storageEvent;
```
```ocaml
type storageEvent = _storageEvent event_like
```
```reasonml
type storageEvent = event_like(_storageEvent);
```
```ocaml
type _svgZoomEvent
```
```reasonml
type _svgZoomEvent;
```
```ocaml
type svgZoomEvent = _svgZoomEvent event_like
```
```reasonml
type svgZoomEvent = event_like(_svgZoomEvent);
```
```ocaml
type _timeEvent
```
```reasonml
type _timeEvent;
```
```ocaml
type timeEvent = _timeEvent event_like
```
```reasonml
type timeEvent = event_like(_timeEvent);
```
```ocaml
type _touchEvent
```
```reasonml
type _touchEvent;
```
```ocaml
type touchEvent = _touchEvent uiEvent_like
```
```reasonml
type touchEvent = uiEvent_like(_touchEvent);
```
```ocaml
type _trackEvent
```
```reasonml
type _trackEvent;
```
```ocaml
type trackEvent = _trackEvent event_like
```
```reasonml
type trackEvent = event_like(_trackEvent);
```
```ocaml
type _transitionEvent
```
```reasonml
type _transitionEvent;
```
```ocaml
type transitionEvent = _transitionEvent event_like
```
```reasonml
type transitionEvent = event_like(_transitionEvent);
```
```ocaml
type _webGlContextEvent
```
```reasonml
type _webGlContextEvent;
```
```ocaml
type webGlContextEvent = _webGlContextEvent event_like
```
```reasonml
type webGlContextEvent = event_like(_webGlContextEvent);
```
```ocaml
type _wheelEvent
```
```reasonml
type _wheelEvent;
```
```ocaml
type wheelEvent = _wheelEvent uiEvent_like
```
```reasonml
type wheelEvent = uiEvent_like(_wheelEvent);
```
```ocaml
type range
```
```reasonml
type range;
```
```ocaml
type selection
```
```reasonml
type selection;
```
```ocaml
type domTokenList
```
```reasonml
type domTokenList;
```
```ocaml
type domSettableTokenList
```
```reasonml
type domSettableTokenList;
```
```
type nodeFilter = {
```
`acceptNode : element -> int;`
```ocaml
}
```
```reasonml
};
```
```ocaml
type nodeIterator
```
```reasonml
type nodeIterator;
```
```ocaml
type treeWalker
```
```reasonml
type treeWalker;
```
```ocaml
type svgRect
```
```reasonml
type svgRect;
```
```ocaml
type svgPoint
```
```reasonml
type svgPoint;
```
```ocaml
type eventPointerId
```
```reasonml
type eventPointerId;
```
```ocaml
type messageChannel
```
```reasonml
type messageChannel;
```
```ocaml
module Storage : sig ... end
```
```reasonml
module Storage: { ... };
```
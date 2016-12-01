package j_group

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"
	"io"

	"github.com/go-openapi/runtime"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// PostRemoteAPIJGroupByRelevanceReader is a Reader for the PostRemoteAPIJGroupByRelevance structure.
type PostRemoteAPIJGroupByRelevanceReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *PostRemoteAPIJGroupByRelevanceReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewPostRemoteAPIJGroupByRelevanceOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	case 401:
		result := NewPostRemoteAPIJGroupByRelevanceUnauthorized()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewPostRemoteAPIJGroupByRelevanceOK creates a PostRemoteAPIJGroupByRelevanceOK with default headers values
func NewPostRemoteAPIJGroupByRelevanceOK() *PostRemoteAPIJGroupByRelevanceOK {
	return &PostRemoteAPIJGroupByRelevanceOK{}
}

/*PostRemoteAPIJGroupByRelevanceOK handles this case with default header values.

Request processed succesfully
*/
type PostRemoteAPIJGroupByRelevanceOK struct {
	Payload *models.DefaultResponse
}

func (o *PostRemoteAPIJGroupByRelevanceOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/JGroup.byRelevance][%d] postRemoteApiJGroupByRelevanceOK  %+v", 200, o.Payload)
}

func (o *PostRemoteAPIJGroupByRelevanceOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.DefaultResponse)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}

// NewPostRemoteAPIJGroupByRelevanceUnauthorized creates a PostRemoteAPIJGroupByRelevanceUnauthorized with default headers values
func NewPostRemoteAPIJGroupByRelevanceUnauthorized() *PostRemoteAPIJGroupByRelevanceUnauthorized {
	return &PostRemoteAPIJGroupByRelevanceUnauthorized{}
}

/*PostRemoteAPIJGroupByRelevanceUnauthorized handles this case with default header values.

Unauthorized request
*/
type PostRemoteAPIJGroupByRelevanceUnauthorized struct {
	Payload *models.UnauthorizedRequest
}

func (o *PostRemoteAPIJGroupByRelevanceUnauthorized) Error() string {
	return fmt.Sprintf("[POST /remote.api/JGroup.byRelevance][%d] postRemoteApiJGroupByRelevanceUnauthorized  %+v", 401, o.Payload)
}

func (o *PostRemoteAPIJGroupByRelevanceUnauthorized) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.UnauthorizedRequest)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}
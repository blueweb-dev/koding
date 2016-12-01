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

// PostRemoteAPIJGroupCountReader is a Reader for the PostRemoteAPIJGroupCount structure.
type PostRemoteAPIJGroupCountReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *PostRemoteAPIJGroupCountReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewPostRemoteAPIJGroupCountOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	case 401:
		result := NewPostRemoteAPIJGroupCountUnauthorized()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewPostRemoteAPIJGroupCountOK creates a PostRemoteAPIJGroupCountOK with default headers values
func NewPostRemoteAPIJGroupCountOK() *PostRemoteAPIJGroupCountOK {
	return &PostRemoteAPIJGroupCountOK{}
}

/*PostRemoteAPIJGroupCountOK handles this case with default header values.

Request processed succesfully
*/
type PostRemoteAPIJGroupCountOK struct {
	Payload *models.DefaultResponse
}

func (o *PostRemoteAPIJGroupCountOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/JGroup.count][%d] postRemoteApiJGroupCountOK  %+v", 200, o.Payload)
}

func (o *PostRemoteAPIJGroupCountOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.DefaultResponse)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}

// NewPostRemoteAPIJGroupCountUnauthorized creates a PostRemoteAPIJGroupCountUnauthorized with default headers values
func NewPostRemoteAPIJGroupCountUnauthorized() *PostRemoteAPIJGroupCountUnauthorized {
	return &PostRemoteAPIJGroupCountUnauthorized{}
}

/*PostRemoteAPIJGroupCountUnauthorized handles this case with default header values.

Unauthorized request
*/
type PostRemoteAPIJGroupCountUnauthorized struct {
	Payload *models.UnauthorizedRequest
}

func (o *PostRemoteAPIJGroupCountUnauthorized) Error() string {
	return fmt.Sprintf("[POST /remote.api/JGroup.count][%d] postRemoteApiJGroupCountUnauthorized  %+v", 401, o.Payload)
}

func (o *PostRemoteAPIJGroupCountUnauthorized) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.UnauthorizedRequest)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}
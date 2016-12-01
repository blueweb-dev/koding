package social_channel

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"
	"io"

	"github.com/go-openapi/runtime"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// PostRemoteAPISocialChannelByNameReader is a Reader for the PostRemoteAPISocialChannelByName structure.
type PostRemoteAPISocialChannelByNameReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *PostRemoteAPISocialChannelByNameReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewPostRemoteAPISocialChannelByNameOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	case 401:
		result := NewPostRemoteAPISocialChannelByNameUnauthorized()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewPostRemoteAPISocialChannelByNameOK creates a PostRemoteAPISocialChannelByNameOK with default headers values
func NewPostRemoteAPISocialChannelByNameOK() *PostRemoteAPISocialChannelByNameOK {
	return &PostRemoteAPISocialChannelByNameOK{}
}

/*PostRemoteAPISocialChannelByNameOK handles this case with default header values.

Request processed succesfully
*/
type PostRemoteAPISocialChannelByNameOK struct {
	Payload *models.DefaultResponse
}

func (o *PostRemoteAPISocialChannelByNameOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/SocialChannel.byName][%d] postRemoteApiSocialChannelByNameOK  %+v", 200, o.Payload)
}

func (o *PostRemoteAPISocialChannelByNameOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.DefaultResponse)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}

// NewPostRemoteAPISocialChannelByNameUnauthorized creates a PostRemoteAPISocialChannelByNameUnauthorized with default headers values
func NewPostRemoteAPISocialChannelByNameUnauthorized() *PostRemoteAPISocialChannelByNameUnauthorized {
	return &PostRemoteAPISocialChannelByNameUnauthorized{}
}

/*PostRemoteAPISocialChannelByNameUnauthorized handles this case with default header values.

Unauthorized request
*/
type PostRemoteAPISocialChannelByNameUnauthorized struct {
	Payload *models.UnauthorizedRequest
}

func (o *PostRemoteAPISocialChannelByNameUnauthorized) Error() string {
	return fmt.Sprintf("[POST /remote.api/SocialChannel.byName][%d] postRemoteApiSocialChannelByNameUnauthorized  %+v", 401, o.Payload)
}

func (o *PostRemoteAPISocialChannelByNameUnauthorized) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.UnauthorizedRequest)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}
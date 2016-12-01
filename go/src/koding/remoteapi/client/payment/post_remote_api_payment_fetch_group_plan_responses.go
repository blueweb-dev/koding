package payment

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"
	"io"

	"github.com/go-openapi/runtime"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// PostRemoteAPIPaymentFetchGroupPlanReader is a Reader for the PostRemoteAPIPaymentFetchGroupPlan structure.
type PostRemoteAPIPaymentFetchGroupPlanReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *PostRemoteAPIPaymentFetchGroupPlanReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewPostRemoteAPIPaymentFetchGroupPlanOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	case 401:
		result := NewPostRemoteAPIPaymentFetchGroupPlanUnauthorized()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewPostRemoteAPIPaymentFetchGroupPlanOK creates a PostRemoteAPIPaymentFetchGroupPlanOK with default headers values
func NewPostRemoteAPIPaymentFetchGroupPlanOK() *PostRemoteAPIPaymentFetchGroupPlanOK {
	return &PostRemoteAPIPaymentFetchGroupPlanOK{}
}

/*PostRemoteAPIPaymentFetchGroupPlanOK handles this case with default header values.

Request processed succesfully
*/
type PostRemoteAPIPaymentFetchGroupPlanOK struct {
	Payload *models.DefaultResponse
}

func (o *PostRemoteAPIPaymentFetchGroupPlanOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/Payment.fetchGroupPlan][%d] postRemoteApiPaymentFetchGroupPlanOK  %+v", 200, o.Payload)
}

func (o *PostRemoteAPIPaymentFetchGroupPlanOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.DefaultResponse)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}

// NewPostRemoteAPIPaymentFetchGroupPlanUnauthorized creates a PostRemoteAPIPaymentFetchGroupPlanUnauthorized with default headers values
func NewPostRemoteAPIPaymentFetchGroupPlanUnauthorized() *PostRemoteAPIPaymentFetchGroupPlanUnauthorized {
	return &PostRemoteAPIPaymentFetchGroupPlanUnauthorized{}
}

/*PostRemoteAPIPaymentFetchGroupPlanUnauthorized handles this case with default header values.

Unauthorized request
*/
type PostRemoteAPIPaymentFetchGroupPlanUnauthorized struct {
	Payload *models.UnauthorizedRequest
}

func (o *PostRemoteAPIPaymentFetchGroupPlanUnauthorized) Error() string {
	return fmt.Sprintf("[POST /remote.api/Payment.fetchGroupPlan][%d] postRemoteApiPaymentFetchGroupPlanUnauthorized  %+v", 401, o.Payload)
}

func (o *PostRemoteAPIPaymentFetchGroupPlanUnauthorized) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.UnauthorizedRequest)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}